<?php
namespace BossEdu\Controller;

use BossEdu\Model\PiLinkQuery;
use BossEdu\Util\Util;

class LectureCtrl
{
    public function authorize()
    {
        return AuthCtrl::check();
    }

    /**
     * @url GET /lectures
     */
    public function getLectures()
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
                "Instruction.StartDate"
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
}
