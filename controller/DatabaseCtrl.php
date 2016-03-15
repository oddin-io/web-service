<?php
namespace BossEdu\Controller;

use BossEdu\Model\SomeoneQuery;
use BossEdu\Util\Util;

class DatabaseCtrl
{
    public function authorize()
    {
        if (!AuthCtrl::check()) {
            return false;
        }

        $personId = AuthCtrl::getSession()["id"];

        $user = SomeoneQuery::create()
            ->usePersonQuery()
                ->filterById($personId)
            ->endUse()
            ->findOne();

        if (!$user->getAdmin()) {
            return false;
        }

        return true;
    }

    /**
     * @url GET /$class
     */
    public function get($class)
    {
        header("Content-Type: text/json");

        $class = "\\bossEdu\\model\\".$class."Query";

        $query = $class::create("t");

        if (isset($_GET) && !empty($_GET)) {
            foreach ($_GET as $key => $value) {
                $query = $query->where("t.{$key} = ?", $value);
            }
        }

        echo json_encode(Util::adjustArrayCase($query->find()->toArray(), "lower"));
    }

    /**
     * @url POST /$class
     */
    public function post($class)
    {
        header("Content-Type: text/json");

        $class = "\\bossEdu\\model\\".$class;
        $data = Util::getPostContents("lower");

        $entity = new $class();
        $entity->fromArray($data, "\\bossEdu\\model\\Map\\".$class."TableMap");
        $entity->save();

        echo json_encode(Util::adjustArrayCase($entity->toArray(), "lower"));
    }

    /**
     * @url PUT /$class
     */
    public function put($class)
    {
        $class = "\\bossEdu\\model\\".$class."Query";

        $data = Util::getPostContents();

        $query = $class::create("t");

        if (isset($_GET) && !empty($_GET)) {
            foreach ($_GET as $key => $value) {
                $query = $query->where("t.{$key} = ?", $value);
            }
        }

        $query->update($data);
    }

    /**
     * @url DELETE /$class
     */
    public function delete($class)
    {
        header("Content-Type: text/json");

        $class = "\\bossEdu\\model\\".$class."Query";

        $query = $class::create("t");

        if (isset($_GET) && !empty($_GET)) {
            foreach ($_GET as $key => $value) {
                $query = $query->where("t.{$key} = ?", $value);
            }

            $query->find()->delete();
        } else {
            $query->deleteAll();
        }
    }
}
