<?php
namespace BossEdu\Controller;

use BossEdu\Model\PiLinkQuery;
use BossEdu\Model\InstructionQuery;
use BossEdu\Model\MpMaterial;
use BossEdu\Model\MpMaterialQuery;
use BossEdu\Model\Presentation;
use BossEdu\Model\PresentationQuery;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;
use Propel\Runtime\ActiveQuery\Criteria;

class PresentationCtrl
{
    public static function auth($presentation_id, $person_id, $profile)
    {
        return (boolean) PiLinkQuery::create()
            ->filterByInstructionId(PresentationCtrl::getInstructionId($presentation_id))
            ->filterByPersonId($person_id)
            ->filterByProfile(["min" => $profile])
            ->findOne();
    }

    public static function getInstructionId($presentation_id) {
        return (int) PresentationQuery::create()
            ->filterById($presentation_id)
            ->select("InstructionId")
            ->findOne();
    }

    public function authorize()
    {
        return AuthCtrl::check();
    }

    /**
     * @url POST /instruction/$instruction_id/presentation
     */
    public function newPresentation($instruction_id)
    {
        header("Content-Type: application/json");

        $instruction_id = urldecode($instruction_id);
        $person = $_SESSION["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 2))
        {
            $postData = Util::getPostContents("lower");

            $presentation = new Presentation();
            $presentation->setSubject($postData["subject"])
                ->setInstructionId($instruction_id)
                ->setPersonId($person)
                ->save();

            $presentation = PresentationQuery::create()
                ->filterById($presentation->getId())
                ->withColumn("Presentation.CreatedAt::date", "\"Presentation.Date\"")
                ->withColumn("Presentation.CreatedAt::time", "\"Presentation.Time\"")
                ->select([
                    "Presentation.Id"
                    , "Presentation.Status"
                    , "Presentation.InstructionId"
                    , "Presentation.PersonId"
                    , "Presentation.Subject"
                ])
                ->findOne();

            echo json_encode(Util::adjustArrayCase(Util::namespacedArrayToNormal($presentation, "Presentation"), "underscore"));
        } else {
            throw new RestException(401, "Enrollment");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/presentation
     */
    public function getPresentations($instruction_id)
    {
        header("Content-Type: application/json");

        $instruction_id = urldecode($instruction_id);
        $person = $_SESSION["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            $presentation = PresentationQuery::create()
                ->join("Presentation.Person")
                ->filterByInstructionId($instruction_id)
                ->withColumn("Presentation.CreatedAt::date", "\"Presentation.Date\"")
                ->withColumn("Presentation.CreatedAt::time", "\"Presentation.Time\"")
                ->select([
                    "Person.Name"
                    , "Presentation.Status"
                    , "Presentation.Id"
                    , "Presentation.Subject"
                ])
                ->orderByCreatedAt(Criteria::DESC)
                ->find()
                ->toArray();

            $presentation = ["presentations" =>
                Util::adjustArrayCase(Util::namespacedArrayToNormal($presentation, "Presentation"), "lower")
            ];
            echo json_encode($presentation);
        } else {
            throw new RestException(401, "Enrollment");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/presentation/$presentation_id
     */
    public function getPresentation($instruction_id, $presentation_id)
    {
        header("Content-Type: application/json");

        $instruction_id = urldecode($instruction_id);
        $person = $_SESSION["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            $presentation = PresentationQuery::create()
                ->join("Presentation.Person")
                ->filterById($presentation_id)
                ->select([
                    "Person.Name"
                    , "Presentation.Status"
                    , "Presentation.Id"
                    , "Presentation.Subject"
                    , "Presentation.CreatedAt"
                ])
                ->findOne();

            $presentation = Util::adjustArrayCase(Util::namespacedArrayToNormal($presentation, "presentation"), "lower");

            echo json_encode($presentation);
        } else {
            throw new RestException(401, "Enrollment");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/presentation/$presentation_id/info
     */
    public function getInfo($instruction_id, $presentation_id)
    {
        header("Content-Type: application/json");

        $instruction_id = urldecode($instruction_id);
        $presentation_id = urldecode($presentation_id);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 0)) {
            $info = PresentationQuery::create()
                ->join("Presentation.Instruction")
                ->join("Instruction.ElHave")
                ->join("ElHave.Event")
                ->join("ElHave.Lecture")
                ->filterById($presentation_id)
                ->withColumn("(select profile from pi_link where instruction_id = Instruction.Id and person_id = ".$person.")", "Profile")
                ->select([
                    "Event.Name"
                    , "Event.Code"
                    , "Lecture.Name"
                    , "Lecture.Code"
                    , "Instruction.StartDate"
                    , "Instruction.Class"
                    , "Instruction.EndDate"
                    , "Presentation.CreatedAt"
                    , "Presentation.Subject"
                ])
                ->findOne();

            $info = Util::adjustArrayCase(Util::namespacedArrayToNormal($info, "Presentation"), "lower");

            echo json_encode($info);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url POST /instruction/$instruction_id/presentation/$presentation_id/material
     */
    public function newMaterial($instruction_id, $presentation_id)
    {
        $presentation_id = urldecode($presentation_id);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 2)) {
            $file = $_FILES["file"];

            if ($file["error"]) {
                throw new RestException(410, "File error: ".$file["error"]);
            }

            $material = new MpMaterial();
            $material->setFile(fopen($file["tmp_name"], "rb"));
            $material->setName(basename($file["name"]));
            $material->setMime($file["type"]);
            $material->setPresentationId($presentation_id);
            $material->save();
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/presentation/$presentation_id/material/$material
     */
    public function getMaterial($instruction_id, $presentation_id, $material_id)
    {
        $presentation_id = urldecode($presentation_id);
        $person = $_SESSION["id"];
        $material_id = urldecode($material_id);

        if (PresentationCtrl::auth($presentation_id, $person, 0)) {
            $material_id = MpMaterialQuery::create()
                ->findOneById($material_id);

            if ($material_id) {
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
     * @url GET /instruction/$instruction_id/presentation/$presentation_id/materials
     */
    public function getMaterials($instruction_id, $presentation_id)
    {
        $presentation_id = urldecode($presentation_id);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 0)) {
            $materials = MpMaterialQuery::create()
                ->filterByPresentationId($presentation_id)
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
     * @url POST /instruction/$instruction_id/presentation/$presentation_id/close
     */
    public function closePresentation($instruction_id, $presentation_id)
    {
        header("Content-Type: application/json");

        $presentation_id = urldecode($presentation_id);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 2)) {
            PresentationQuery::create()
                ->filterById($presentation_id)
                ->update(["Status" => 1]);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }
}
