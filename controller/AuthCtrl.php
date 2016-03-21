<?php
namespace BossEdu\Controller;

use BombArea\SSO\Client;
use BombArea\SSO\LoggedClient;
use BossEdu\Model\PersonQuery;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;

class AuthCtrl
{
    /**
     * @noAuth
     * @url OPTIONS /login
     */
    public function optionsLogin()
    {
        AuthCtrl::preFlightResponse();
    }

    /**
     * @url POST /login
     */
    public function login()
    {
        $postData = Util::getPostContents("lower");
        $postData["persist"] = $postData["persist"] ?? false;

        try {
            $loggedClient = self::getClient()->login($postData["email"], $postData["password"]);
            self::setCookie($loggedClient->getSessionToken(), $postData["persist"]);

            $personId = PersonQuery::create()
                ->findOneByEmail($postData["email"])
                ->getId();

            $loggedClient->setSessionData([
                "id" => $personId,
                "persist" => $postData["persist"]
            ]);
        } catch (\Exception $ex) {
            throw new RestException(401, $ex->getMessage());
        }
    }

    /**
     * @noAuth
     * @url OPTIONS /logout
     */
    public function optionsLogout()
    {
        AuthCtrl::preFlightResponse();
    }

    /**
     * @url GET /logout
     * @url POST /logout
     */
    public function logout()
    {
        $loggedClient = new LoggedClient(self::getClient(), self::getAuthToken());

        try {
            $loggedClient->logout();
            self::deleteCookie();
        } catch (\Exception $ex) {
            throw new RestException(401, $ex->getMessage());
        }
    }

    public static function preFlightResponse()
    {
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Methods: POST, GET, DELETE, OPTIONS, PUT");
        header("Access-Control-Allow-Headers: Content-Type, Accept, X-Auth-Token");
        header("Access-Control-Max-Age: 86400");
    }

    public static function getSession()
    {
        $loggedUser = self::buildLoggedClient();
        return $loggedUser->getSessionData();
    }

    public static function setSession($values)
    {
        $loggedUser = self::buildLoggedClient();
        return $loggedUser->setSessionData($values);
    }

    public static function getClient()
    {
        return new Client("http://auth.localhost/controller", "client", "asd123");
    }

    public static function check()
    {
        if (!self::getAuthToken()) return false;

        return true;
    }

    private static function buildLoggedClient()
    {
        if(!self::check()) throw new \Exception("You aren't logged");

        return new LoggedClient(self::getClient(), self::getAuthToken());
    }

    private static function setCookie($value, $persist = false)
    {
        $ttl = 0;

        if ($persist) $ttl = time() + 3600 * 24 * 60;

        setcookie(self::getCookieName(), $value, $ttl, "/");
    }

    private static function deleteCookie()
    {
        setcookie(self::getCookieName(), "", -3600, "/");
    }

    private static function getCookieName()
    {
        return "sso_client_token";
    }

    /**
     * @return string|null
     */
    private static function getAuthToken()
    {
        if (isset($_SERVER["HTTP_X_AUTH_TOKEN"])) return $_SERVER["HTTP_X_AUTH_TOKEN"];
        if (isset($_COOKIE[self::getCookieName()])) return $_COOKIE[self::getCookieName()];

        return null;
    }
}
