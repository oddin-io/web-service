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

    public static function setCurrentInstruction($event, $lecture, $start_date, $class, $person)
    {
        PersonQuery::create()
            ->filterById($person)
            ->update(["CurrentInstruction" => InstructionCtrl::getInstructionId($event, $lecture, $start_date, $class)]);
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

    public static function resetCurrentInstruction($person)
    {
        PersonQuery::create()
            ->filterById($person)
            ->update(["CurrentInstruction" => null]);
    }

    public static function auth($event, $lecture, $start_date, $class, $person, $profile)
    {
        return (boolean)PiLinkQuery::create()
            ->useInstructionQuery()
            ->filterByEventCode($event)
            ->filterByLectureCode($lecture)
            ->filterByClass($class)
            ->filterByStartDate($start_date)
            ->endUse()
            ->filterByPersonId($person)
            ->filterByProfile(["min" => $profile])
            ->findOne();
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/info
     */
    public function getInfo($event, $lecture, $start_date, $class)
    {
        header("Content-Type: application/json");

        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);
        $person = $_SESSION["id"];

        if (self::auth($event, $lecture, $start_date, $class, $person, 0)) {
            $info = InstructionQuery::create()
                ->join("Instruction.ElHave")
                ->join("ElHave.Event")
                ->join("ElHave.Lecture")
                ->filterByEventCode($event)
                ->filterByLectureCode($lecture)
                ->filterByStartDate($start_date)
                ->filterByClass($class)
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
     * @url GET /$event/$lecture/$start_date/$class/participants
     */
    public function getParticipants($event, $lecture, $start_date, $class)
    {
        header("Content-Type: application/json");

        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);
        $person = $_SESSION["id"];

        if (self::auth($event, $lecture, $start_date, $class, $person, 0)) {
            $lectureHashHash = self::getInstructionId($event, $lecture, $start_date, $class);

            $participants = PiLinkQuery::create()
                ->join("PiLink.Person")
                ->useInstructionQuery()
                ->filterByEventCode($event)
                ->filterByLectureCode($lecture)
                ->filterByStartDate($start_date)
                ->filterByClass($class)
                ->endUse()
                ->where("PiLink.PersonId != ?", $person)
                ->select(["Person.Name", "PiLink.Profile"])
                ->withColumn("'" . $lectureHashHash . "' = Person.CurrentInstruction", "\"Person.Online\"")
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

    /**
     * @url GET /$event/$lecture/$start_date/$class/historic
     */
    public function getPresentations($event, $lecture, $start_date, $class)
    {
        header("Content-Type: application/json");

        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);
        $person = $_SESSION["id"];

        if (self::auth($event, $lecture, $start_date, $class, $person, 0)) {
            $presentation = PresentationQuery::create()
                ->join("Presentation.Person")
                ->useInstructionQuery()
                ->filterByEventCode($event)
                ->filterByLectureCode($lecture)
                ->filterByStartDate($start_date)
                ->filterByClass($class)
                ->endUse()
                ->withColumn("Presentation.CreatedAt::date", "\"Presentation.Date\"")
                ->withColumn("Presentation.CreatedAt::time", "\"Presentation.Time\"")
                ->select([
                    "Person.Name"
                    , "Presentation.Status"
                    , "Presentation.Id"
                    , "Presentation.Subject"
                ])
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
}
