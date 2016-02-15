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

class PresentationCtrl
{
    public static function auth($presentation_id, $person_id, $profile)
    {
        $presentation = PresentationQuery::create()
            ->filterById($presentation_id)
            ->findOne();

        return (boolean) PiLinkQuery::create()
            ->filterByInstructionId($presentation->getInstructionId())
            ->filterByPersonId($person_id)
            ->filterByProfile(["min" => $profile])
            ->findOne();
    }

    public function authorize()
    {
        return AuthCtrl::check();
    }

    /**
     * @url POST /$event/$lecture/$start_date/$class/presentation
     */
    public function newPresentation($event, $lecture, $start_date, $class)
    {
        header("Content-Type: application/json");

        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);
        $person = $_SESSION["id"];

        if (InstructionCtrl::auth($event, $lecture, $start_date, $class, $person, 2))
        {
            $postData = Util::getPostContents("lower");

            $instruction = InstructionQuery::create()
                ->filterByEventCode($event)
                ->filterByLectureCode($lecture)
                ->filterByClass($class)
                ->filterByStartDate($start_date)
                ->findOne();

            $presentation = new Presentation();
            $presentation->setSubject($postData["subject"])
                ->setInstructionId($instruction->getId())
                ->setPersonId($person)
                ->save();

            echo json_encode(Util::adjustArrayCase($presentation->toArray(), "lower"));
        } else {
            throw new RestException(401, "Enrollment");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$id
     */
    public function getPresentation($event, $lecture, $start_date, $class, $id)
    {
        header("Content-Type: application/json");

        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);
        $person = $_SESSION["id"];

        if (InstructionCtrl::auth($event, $lecture, $start_date, $class, $person, 0)) {
            $presentation = PresentationQuery::create()
                ->join("Presentation.Person")
                ->filterById($id)
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
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/info
     */
    public function getInfo($event, $lecture, $start_date, $class, $presentation)
    {
        header("Content-Type: application/json");

        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);
        $presentation = urldecode($presentation);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $info = PresentationQuery::create()
                ->join("Presentation.Instruction")
                ->join("Instruction.ElHave")
                ->join("ElHave.Event")
                ->join("ElHave.Lecture")
                ->filterById($presentation)
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
     * @url POST /$event/$lecture/$start_date/$class/presentation/$presentation/material
     */
    public function newMaterial($event, $lecture, $start_date, $class, $presentation)
    {
        $presentation = urldecode($presentation);
        $person = 3;

        if (PresentationCtrl::auth($presentation, $person, 2)) {
            $file = $_FILES["file"];

            if ($file["error"]) {
                throw new RestException(410, "File error: ".$file["error"]);
            }

            $material = new MpMaterial();
            $material->setFile(fopen($file["tmp_name"], "rb"));
            $material->setName(basename($file["name"]));
            $material->setMime($file["type"]);
            $material->setPresentationId($presentation);
            $material->save();
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/material/$material
     */
    public function getMaterial($event, $lecture, $start_date, $class, $presentation, $material)
    {
        $presentation = urldecode($presentation);
        $person = $_SESSION["id"];
        $material = urldecode($material);

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $material = MpMaterialQuery::create()
                ->findOneById($material);

            if ($material) {
                header("Content-Type: ".$material->getMime());
                header("Content-Disposition: attachment; filename=\"".$material->getName()."\"");
                header("Cache-Control: no-cache, no-store, must-revalidate");
                header("Pragma: no-cache");
                header("Expires: 0");
                fpassthru($material->getFile());
                exit(0);
            } else {
                throw new RestException(404, "Arquivo");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/materials
     */
    public function getMaterials($event, $lecture, $start_date, $class, $presentation)
    {
        $presentation = urldecode($presentation);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $materials = MpMaterialQuery::create()
                ->filterByPresentationId($presentation)
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
     * @url POST /$event/$lecture/$start_date/$class/presentation/$presentation/close
     */
    public function closePresentation($event, $lecture, $start_date, $class, $presentation)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 2)) {
            PresentationQuery::create()
                ->filterById($presentation)
                ->update(["Status" => 1]);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }
}
