<?php
namespace BossEdu\Controller;

use BossEdu\Model\Doubt;
use BossEdu\Model\DoubtQuery;
use BossEdu\Model\Map\DoubtTableMap;
use BossEdu\Model\PdLike;
use BossEdu\Model\PdLikeQuery;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;
use Propel\Runtime\ActiveQuery\Criteria;

class DoubtCtrl
{
    public function authorize()
    {
        return AuthCtrl::check();
    }

    /**
     * @url POST /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt
     */
    public function newDoubt($event, $lecture, $start_date, $class, $presentation)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $data = Util::getPostContents("lower");
            $data["status"] = 0;
            $data["person_id"] = $person;
            $data["presentation_id"] = $presentation;

            $doubt = new Doubt();
            $doubt->fromArray($data, DoubtTableMap::TYPE_FIELDNAME);
            $doubt->save();

            $doubt = Util::adjustArrayCase($doubt->toArray(), "lower");
            echo json_encode($doubt);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt
     */
    public function getDoubts($event, $lecture, $start_date, $class, $presentation)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $doubts = PdLikeQuery::create()
                ->join("PdLike.Doubt", Criteria::RIGHT_JOIN)
                ->join("Doubt.Person")
                ->where("Doubt.PresentationId = ?", $presentation)
                ->_if(isset($_GET["status"]))
                ->where("Doubt.Status = ?", $_GET["status"])
                ->_endif()
                ->select([
                    "Doubt.Id"
                    , "Doubt.Status"
                    , "Doubt.Text"
                    , "Doubt.CreatedAt"
                    , "Doubt.Anonymous"
                    , "Doubt.PresentationId"
                    , "Person.Id"
                    , "Person.Name"
                ])
                ->withColumn("count(PdLike.DoubtId)", "\"Doubt.Likes\"")
                ->withColumn("(select count(doubt_id) from contribution where doubt_id = Doubt.Id)", "\"Doubt.Contributions\"")
                ->withColumn($person." in(select person_id from pd_like where doubt_id = Doubt.Id)", "\"Doubt.Like\"")
                ->groupByDoubtId()
                ->groupByPersonId()
                ->find()
                ->toArray();

            $response = [];

            for ($i = 0, $length = count($doubts); $i < $length; $i++) {
                if ($doubts[$i]["Person.Id"] == $person) {
                    $doubts[$i]["Person.Name"] = "Eu";
                } else if ($doubts[$i]["Doubt.Anonymous"]) {
                    $doubts[$i]["Person.Id"] = 0;
                    $doubts[$i]["Person.Name"] = "Anônimo";
                }
            }

            $doubts = Util::namespacedArrayToNormal($doubts, "Doubt");
            for ($i = 0, $length = count($doubts); $i < $length; $i++) {
                $response[$doubts[$i]["Id"]] = $doubts[$i];
            }

            $response = ["doubts" =>
                Util::adjustArrayCase($response, "lower")
            ];

            echo json_encode($response);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt
     */
    public function getDoubt($event, $lecture, $start_date, $class, $presentation, $doubt = null)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $doubts = PdLikeQuery::create()
                ->join("PdLike.Doubt", Criteria::RIGHT_JOIN)
                ->join("Doubt.Person")
                ->where("Doubt.PresentationId = ?", $presentation)
                ->where("Doubt.Id = ?", $doubt)
                ->select([
                    "Doubt.Id"
                    , "Doubt.Status"
                    , "Doubt.Text"
                    , "Doubt.CreatedAt"
                    , "Doubt.Anonymous"
                    , "Doubt.PresentationId"
                    , "Person.Id"
                    , "Person.Name"
                ])
                ->withColumn("count(PdLike.DoubtId)", "\"Doubt.Likes\"")
                ->withColumn("(select count(doubt_id) from contribution where doubt_id = Doubt.Id)", "\"Doubt.Contributions\"")
                ->withColumn($person." in(select person_id from pd_like where doubt_id = Doubt.Id)", "\"Doubt.Like\"")
                ->groupByDoubtId()
                ->groupByPersonId()
                ->findOne();

            if ($doubts["Person.Id"] == $person) {
                $doubts["Person.Name"] = "Eu";
            } else if ($doubts["Doubt.Anonymous"]) {
                $doubts["Person.Id"] = 0;
                $doubts["Person.Name"] = "Anônimo";
            }

            $doubts = Util::namespacedArrayToNormal($doubts, "Doubt");
            $doubts = Util::adjustArrayCase($doubts, "lower");

            echo json_encode($doubts);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url POST /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/like
     */
    public function like($event, $lecture, $start_date, $class, $presentation, $doubt)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $d = DoubtQuery::create()
                ->filterById($doubt)
                ->findOne();

            if (!($d->getPersonId() == $person)) {
                $pdLike = new PdLike();
                $pdLike->setDoubtId($doubt);
                $pdLike->setPersonId($person);
                $pdLike->save();
            } else {
                throw new RestException(401, "Forever Alone");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url DELETE /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/like
     */
    public function removeLike($event, $lecture, $start_date, $class, $presentation, $doubt)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $d = DoubtQuery::create()
                ->filterById($doubt)
                ->findOne();

            if (!($d->getPersonId() == $person)) {
                $pdLike = new PdLike();
                $pdLike->setDoubtId($doubt);
                $pdLike->setPersonId($person);
                $pdLike->delete();
            } else {
                throw new RestException(401, "Forever Alone");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url POST /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/understand
     */
    public function understand($event, $lecture, $start_date, $class, $presentation, $doubt)
    {
        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $d = PdLikeQuery::create()
                ->join("PdLike.Doubt")
                ->where("Doubt.Id = ?", $doubt)
                ->where("Doubt.Status = ?", 2)
                ->where("PdLike.PersonId = ?", $person)
                ->findOne();

            if ($d) {
                PdLikeQuery::create()
                    ->where("PdLike.DoubtId = ?", $doubt)
                    ->where("PdLike.PersonId = ?", $person)
                    ->update(["Understand" => true]);
            } else {
                throw new RestException(401, "Unauthorized");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url DELETE /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/understand
     */
    public function removeUnderstand($event, $lecture, $start_date, $class, $presentation, $doubt)
    {
        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $d = PdLikeQuery::create()
                ->join("PdLike.Doubt")
                ->where("PdLike.Idd = ?", $doubt)
                ->where("PdLike.Idp = ?", $person)
                ->where("Doubt.Status = ?", 2)
                ->where("PdLike.Understand = ?", true)
                ->findOne();

            if ($d) {
                PdLikeQuery::create()
                    ->where("PdLike.Idd = ?", $doubt)
                    ->where("PdLike.Idp = ?", $person)
                    ->update(["Understand" => false]);
            } else {
                throw new RestException(401, "Unauthorized");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url POST /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/change-status
     */
    public function changeStatus($event, $lecture, $start_date, $class, $presentation, $doubt)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 2)) {
            $data = Util::getPostContents("lower");

            DoubtQuery::create()
                ->filterById($doubt)
                ->update(["Status" => $data["status"]]);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }
}
