<?php
namespace BossEdu\Controller;

use BossEdu\Model\PersonQuery;
use BossEdu\Model\SomeoneQuery;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;
use Mailgun\Mailgun;
use Jasny\SSO\Broker;

class AuthCtrl
{
    public static function check()
    {
        if (!isset($_SESSION)) session_start();

        AuthCtrl::refreshSession();

        if (isset($_SESSION["email"])) {
            $user = SomeoneQuery::create()
                ->filterByEmail($_SESSION["email"])
                ->filterByPassword($_SESSION["password"])
                ->findOne();

            if ($user) {
                return true;
            }
        }

        AuthCtrl::destroySession();
    }

    public static function startSession($persist = false)
    {
        if ($persist) {
            session_set_cookie_params(time() + 3600 * 24 * 60); // 2 Months
        }

        session_start();
    }

    public static function refreshSession()
    {
        if (!isset($_SESSION)) session_start();

        if ($_SESSION["persist"]) {
            $params = session_get_cookie_params();
            setcookie(session_name(), session_id(), time() + 3600 * 24 * 60,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }
    }

    public static function destroySession()
    {
        if (!isset($_SESSION)) session_start();

        if (isset($_SESSION["id"])) InstructionCtrl::resetCurrentInstruction($_SESSION["id"]);

        $_SESSION = [];

        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }

        session_destroy();
    }

    /**
     * @url POST /login
     */
    public function login()
    {
        $broker = new Broker("http://localhost:9000", "Alice", "8iwzik1bwd");
        $broker->attach(true);

        $user = Util::getPostContents("lower");

        echo json_encode($user, JSON_PRETTY_PRINT);

        $broker->login($user['username'], $user['password']);
    }

    /**
     * @url GET /logout
     * @url POST /logout
     */
    public function logout()
    {
        $broker = new Broker("http://localhost:9000", "Alice", "8iwzik1bwd");
        $broker->attach(true);
        $broker->logout();
    }

    /**
     * @url POST /recover-password
     */
    public function recoverPassword()
    {
        $email = Util::getPostContents("lower")["email"];

        $user = SomeoneQuery::create()
            ->findOneByEmail($email);

        if ($user) {
            $mgClient = new Mailgun("key-c34a8cf7dc6291c18df4fd0c92d3e6ba");
            $domain = "sandboxa45ec9d3f56c49078aad139e56984298.mailgun.org";

            $mgClient->sendMessage("$domain",
                [ "from"    => "Mirage <postmaster@sandboxa45ec9d3f56c49078aad139e56984298.mailgun.org>",
                    "to"      => $user->getEmail(),
                    "subject" => "Recuperação de Senha",
                    "text"    => $user->getPassword()
                ]
            );
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @noAuth
     * @url GET /test
     */
    public function getTest()
    {
        $broker = new Broker("http://localhost:9000", "Alice", "8iwzik1bwd");
        $broker->attach(true);
        $user = $broker->getUserInfo();

        echo json_encode($user, JSON_PRETTY_PRINT);
    }

    /**
     * @noAuth
     * @url POST /test
     */
    public function postTest()
    {
        echo json_encode($_FILES);
        echo json_encode($_POST);
    }
}
