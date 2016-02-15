<?php
namespace BossEdu\Controller;

use BossEdu\Model\PiLinkQuery;
use BossEdu\Model\PresentationQuery;

define("__VIEWFOLDER__", __DIR__."/../view/pages");

class FrontEndCtrl
{
    public function authorize()
    {
        return AuthCtrl::check();
    }

    /**
     * @noAuth
     * @url GET /recover-password
     */
    public function recoverPassword()
    {
        echo file_get_contents(__VIEWFOLDER__."/recuperar_senha.html");
    }

    /**
     * @url GET /lectures
     */
    public function lectures()
    {
        InstructionCtrl::resetCurrentInstruction($_SESSION["id"]);

        echo file_get_contents(__VIEWFOLDER__."/palestras.html");
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/material
     */
    public function material($event, $lecture, $start_date, $class)
    {
        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);

        $person = $_SESSION["id"];

        $profile = $this->getProfile($event, $lecture, $start_date, $class, $person);

        InstructionCtrl::setCurrentInstruction($event, $lecture, $start_date, $class, $_SESSION["id"]);

        if ($profile >= 2) {
            echo file_get_contents(__VIEWFOLDER__."/material-p.html");
            return;
        }

        echo file_get_contents(__VIEWFOLDER__."/material-o.html");
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/participants
     */
    public function participants($event, $lecture, $start_date, $class)
    {
        InstructionCtrl::setCurrentInstruction($event, $lecture, $start_date, $class, $_SESSION["id"]);

        echo file_get_contents(__VIEWFOLDER__."/participantes.html");
    }

    public function getProfile($event, $lecture, $start_date, $class, $person)
    {
        return (int) PiLinkQuery::create()
            ->useInstructionQuery()
            ->filterByEventCode($event)
            ->filterByLectureCode($lecture)
            ->filterByClass($class)
            ->filterByStartDate($start_date)
            ->endUse()
            ->filterByPersonId($person)
            ->select("PiLink.Profile")
            ->findOne();
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/historic
     */
    public function historic($event, $lecture, $start_date, $class)
    {
        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);

        $person = $_SESSION["id"];

        $profile = $this->getProfile($event, $lecture, $start_date, $class, $person);

        InstructionCtrl::setCurrentInstruction($event, $lecture, $start_date, $class, $_SESSION["id"]);

        if ($profile >= 2) {
            echo file_get_contents(__VIEWFOLDER__."/historico-p.html");
            return;
        }

        echo file_get_contents(__VIEWFOLDER__."/historico-o.html");
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/current
     */
    public function currentPresentation($event, $lecture, $start_date, $class)
    {
        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);

        $id = PresentationQuery::create()
            ->useInstructionQuery()
            ->filterByEventCode($event)
            ->filterByLectureCode($lecture)
            ->filterByClass($class)
            ->filterByStartDate($start_date)
            ->endUse()
            ->select("Id")
            ->findOne();

        if ($id) {
            $url = "/app/{$event}/{$lecture}/{$start_date}/{$class}/presentation/{$id}";
            header("Location: {$url}");
        } else {
            $url = "/app/{$event}/{$lecture}/{$start_date}/{$class}/historic";
            header("Location: {$url}");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$id
     */
    public function presentation($event, $lecture, $start_date, $class, $id)
    {
        $event = urldecode($event);
        $lecture = urldecode($lecture);
        $start_date = urldecode($start_date);
        $class = urldecode($class);

        InstructionCtrl::setCurrentInstruction($event, $lecture, $start_date, $class, $_SESSION["id"]);

        $profile = $this->getProfile($event, $lecture, $start_date, $class, $_SESSION["id"]);

        if ($profile >= 2) {
            echo file_get_contents(__VIEWFOLDER__."/apresentacao-p-slick_carousel.html");
            return;
        }

        echo file_get_contents(__VIEWFOLDER__."/apresentacao-o.html");
    }
}
