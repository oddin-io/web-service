<?php
namespace BossEdu\Controller;


use BossEdu\Model\InstructionQuery;
use BossEdu\Model\PersonQuery;
use BossEdu\Model\PiLinkQuery;
use BossEdu\Model\PresentationQuery;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;

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

    /**
     * @url GET /instruction
     */
    public function getInstruction()
    {
        header("Content-Type: application/json");

        $person = $_SESSION["id"];

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
        $person = $_SESSION["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            $info = InstructionQuery::create()
                ->join("Instruction.ElHave")
                ->join("ElHave.Event")
                ->join("ElHave.Lecture")
                ->filterById($instruction_id)
                ->select([
                    "Instruction.StartDate"
                    , "Instruction.EndDate"
                    , "Instruction.Class"
                    , "Event.Code"
                    , "Event.Name"
                    , "Lecture.Code"
                    , "Lecture.Name"
                    , "Lecture.Workload"
                ])
                ->findOne();

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
        $person = $_SESSION["id"];

        if (InstructionCtrl::auth($instruction_id, $person, 0)) {
            $participants = PiLinkQuery::create()
                ->join("PiLink.Person")
                ->filterByInstructionId($instruction_id)
                ->where("PiLink.PersonId != ?", $person)
                ->select(["Person.Name", "PiLink.Profile"])
                ->find()
                ->toArray();

            $participants = ["participants" =>
                Util::adjustArrayCase(Util::namespacedArrayToNormal($participants, ["Person", "PiLink"]), "lower")
            ];
            echo json_encode($participants);
        } else {
            throw new RestException(401, "Enrollment");
        }
    }
}
