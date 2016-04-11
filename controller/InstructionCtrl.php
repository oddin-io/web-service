<?php
namespace BossEdu\Controller;

use BossEdu\Model\InstructionQuery;
use BossEdu\Model\MiMaterial;
use BossEdu\Model\MiMaterialQuery;
use BossEdu\Model\PersonQuery;
use BossEdu\Model\PiLinkQuery;
use BossEdu\Model\PiStatusQuery;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;
use Propel\Runtime\ActiveQuery\Criteria;

class InstructionCtrl
{
    public function authorize()
    {
        return AuthCtrl::check();
    }

    public static function getInstructionId($event, $lecture, $start_date, $class)
    {
        return (int) InstructionQuery::create()
            ->filterByEventCode($event)
            ->filterByLectureCode($lecture)
            ->filterByStartDate($start_date)
            ->filterByClass($class)
            ->select("Id")
            ->findOne();
    }

    public static function auth($instruction_id, $person, $profile)
    {
        return (boolean)PiLinkQuery::create()
            ->filterByInstructionId($instruction_id)
            ->filterByPersonId($person)
            ->filterByProfile(["min" => $profile])
            ->findOne();
    }

    public static function getCurrentInstruction($person_id)
    {
        $status = PiStatusQuery::create()
            ->findOneByPersonId($person_id);

        $interval = new \DateInterval("3600S");
        $gap = $status->getEnterAt()->diff(new \DateTime());

        $result = $status->getInstructionId();
        if ($gap > $interval) {
            $status->setOnline(false);
            $status->save();
            $result = 0;
        }

        return $result;
    }

    public static function setCurrentInstruction($person_id, $instruction_id)
    {
        $status = PiStatusQuery::create()
            ->filterByPersonId($person_id)
            ->filterByInstructionId($instruction_id)
            ->findOneOrCreate();

        $status->setEnterAt(new \DateTime());
        $status->setOnline(true);
        $status->save();
    }

    public static function resetCurrentInstruction($person_id)
    {
        PiStatusQuery::create()
            ->filterByPersonId($person_id)
            ->update(["Online" => false]);
    }

    public static function updateCurrentInstructionToAll()
    {
        PiStatusQuery::create()
            ->where("PiStatus.EnterAt + '1 hour'::interval < current_timestamp(0)")
            ->update(["Online" => false]);
    }

    /**
     * @url GET /instruction
     */
    public function getInstructions()
    {
        header("Content-Type: application/json");

        $person = AuthCtrl::getSession()["id"];

        $lectures = PiLinkQuery::create()
            ->join("PiLink.Instruction")
            ->join("Instruction.ElHave")
            ->join("ElHave.Event")
            ->join("ElHave.Lecture")
            ->filterByPersonId($person)
            ->select([
                "Instruction.Id"
                , "Instruction.StartDate"
                , "Instruction.EndDate"
                , "Instruction.Class"
                , "Event.Code"
                , "Event.Name"
                , "Lecture.Code"
                , "Lecture.Name"
                , "PiLink.Profile"
            ])
            ->find()
            ->toArray();

        $lectures = ["lectures" =>
            Util::adjustArrayCase(Util::namespacedArrayToNormal($lectures, ["Instruction", "Lecture", "PiLink"]), "lower")
        ];
        echo json_encode($lectures);
    }

    /**
     * @url GET /instruction/$instruction_id/info
     */
    public function getInfo($instruction_id)
    {
        header("Content-Type: application/json");

        $instruction_id = urldecode($instruction_id);
        $person = AuthCtrl::getSession()["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            $info = InstructionQuery::create()
                ->join("Instruction.ElHave")
                ->join("ElHave.Event")
                ->join("ElHave.Lecture")
                ->filterById($instruction_id)
                ->select([
                    "Instruction.Id"
                    , "Instruction.StartDate"
                    , "Instruction.EndDate"
                    , "Instruction.Class"
                    , "Event.Code"
                    , "Event.Name"
                    , "Lecture.Code"
                    , "Lecture.Name"
                    , "Lecture.Workload"
                ])
                ->findOne();

            InstructionCtrl::setCurrentInstruction($person, $instruction_id);

            $info = Util::adjustArrayCase(Util::namespacedArrayToNormal($info, ["Instruction", "Lecture"]), "lower");
            echo json_encode($info);
        } else {
            throw new RestException(401, "Enrollment");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/participants
     */
    public function getParticipants($instruction_id)
    {
        header("Content-Type: application/json");

        $instruction_id = urldecode($instruction_id);
        $person = AuthCtrl::getSession()["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            InstructionCtrl::updateCurrentInstructionToAll();

            $participants = PersonQuery::create()
                ->leftJoinPiStatus()
                ->usePiLinkQuery()
                    ->filterByInstructionId($instruction_id)
                ->endUse()
                ->where("PiLink.PersonId != ?", $person)
                ->select(["Person.Name", "PiLink.Profile"])
                ->withColumn("coalesce(PiStatus.Online, false)" , "\"PiStatus.Online\"")
                ->find()
                ->toArray();

            $participants = ["participants" =>
                Util::adjustArrayCase(Util::namespacedArrayToNormal($participants, ["Person", "PiLink", "PiStatus"]), "lower")
            ];
            echo json_encode($participants);
        } else {
            throw new RestException(401, "Enrollment");
        }
    }

    /**
     * @url POST /instruction/$instruction_id/material
     */
    public function newMaterial($instruction_id)
    {
        $instruction_id = urldecode($instruction_id);
        $person = AuthCtrl::getSession()["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 2)) {
            $file = $_FILES["file"];

            if ($file["error"]) {
                throw new RestException(410, "File error: ".$file["error"]);
            }

            $material = new MiMaterial();
            $material->setFile(fopen($file["tmp_name"], "rb"));
            $material->setName(basename($file["name"]));
            $material->setMime($file["type"]);
            $material->setInstructionId($instruction_id);
            $material->save();
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/material/$material_id
     */
    public function getMaterial($instruction_id, $material_id)
    {
        $instruction_id = urldecode($instruction_id);
        $person = AuthCtrl::getSession()["id"];
        $material_id = urldecode($material_id);

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            $material_id = MiMaterialQuery::create()
                ->findOneById($material_id);

            if ($material_id) {
                header("Access-Control-Expose-Headers: Content-Disposition");
                header("Content-Type: ".$material_id->getMime());
                header("Content-Disposition: attachment; filename=\"".$material_id->getName()."\"");
                header("Cache-Control: no-cache, no-store, must-revalidate");
                header("Pragma: no-cache");
                header("Expires: 0");
                fpassthru($material_id->getFile());
                exit(0);
            } else {
                throw new RestException(404, "Arquivo");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/material
     */
    public function getMaterials($instruction_id)
    {
        $instruction_id = urldecode($instruction_id);
        $person = AuthCtrl::getSession()["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            $materials = MiMaterialQuery::create()
                ->filterByInstructionId($instruction_id)
                ->select(["Id", "Name", "Mime"])
                ->find();

            $materials = ["materials" =>
                Util::adjustArrayCase($materials, "lower")
            ];
            echo json_encode($materials);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @noAuth
     * @url OPTIONS /instruction
     * @url OPTIONS /instruction/$instruction_id/info
     * @url OPTIONS /instruction/$instruction_id/participants
     * @url OPTIONS /instruction/$instruction_id/material
     * @url OPTIONS /instruction/$instruction_id/material/$material_id
     */
    public function options($instruction_id = null, $material_id = null)
    {
        AuthCtrl::preFlightResponse();
    }
}
