<?php
namespace BossEdu\Controller;

use BossEdu\Model\SomeoneQuery;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;
use Mailgun\Mailgun;
use Jasny\SSO\Broker;

class AuthCtrl
{
    public static function check()
    {
        $broker = self::attach();
        $user = $broker->getUserInfo();

        if ($user) {
            session_start();
            $_SESSION["id"] = $user["id"];
            return true;
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    private static function attach()
    {
        $broker = new Broker("http://auth.localhost", "Alice", "8iwzik1bwd");
        $broker->attach(true);

        return $broker;
    }

    /**
     * @url POST /login
     */
    public function login()
    {
        $broker = self::attach();
        $user = Util::getPostContents("lower");

        try {
            $broker->login($user["email"], $user["password"]);
        } catch (\Exception $ex) {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /logout
     * @url POST /logout
     */
    public function logout()
    {
        $broker = self::attach();
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
     * @url GET /check
     */
    public function checkStatus()
    {
        self::check();
        echo $_SESSION["id"];
    }

    /**
     * @url GET /test
     */
    public function getTest()
    {
        $broker = self::attach();
        $user = $broker->getUserInfo();

        echo json_encode($user, JSON_PRETTY_PRINT);
    }

    /**
     * @url POST /test
     */
    public function postTest()
    {
        echo json_encode($_FILES);
        echo json_encode($_POST);
    }
}
