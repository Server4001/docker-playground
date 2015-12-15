<?php
/**
 * Class for setting up WordPress hooks needed by the rate limiter plugin.
 *
 * @category     Hooks
 * @package      Login Rate Limiter - Redis
 * @copyright    Copyright (c) 2015 Bentler Design (www.bricebentler.com)
 * @author       Brice Bentler (me@bricebentler.com)
 */

namespace LoginLimiter;

use Predis\Client;
use WP_Error;
use WP_User;

class SetupHooks
{

    const RATE_LIMIT_REDIS_DB = 2;
    const MAX_LOGIN_ATTEMPTS = 3;
    const IP_LOCK_TIMEOUT_MINUTES = 60;

    /** @var Client|null */
    private $_redis = null;

    /**
     * Override the default constructor, so that actions and filters can be hooked into.
     *
     * @param Client $redis
     */
    public function __construct(Client $redis)
    {
        add_action('login_head', array($this, 'renderErrorMessage'));
        add_action('wp_login', array($this, 'handleLoginSuccess'), 10, 2);
        add_action('wp_login_failed', array($this, 'handleFailedLogin'));
        add_filter('authenticate', array($this, 'checkUserIp'),  19, 3);

        $this->_redis = $redis;
        $this->_redis->select(self::RATE_LIMIT_REDIS_DB);
    }

    /**
     * Renders an error message to the login page.
     */
    public function renderErrorMessage()
    {

    }

    /**
     * Handles a successful login, resetting the user's login count in Redis.
     *
     * @param string $username
     * @param WP_User $user
     */
    public function handleLoginSuccess($username, WP_User $user)
    {

    }

    /**
     * Handles a failed login, updating the user's login count in Redis, possibly blocking the account.
     * NOTE: Also fires when an invalid username is entered (not in database).
     *
     * @param string $username
     */
    public function handleFailedLogin($username)
    {
        $ip = self::getUserIp();
        $redisRow = $this->_redis->hgetall("rate:{$ip}");

        if (!is_array($redisRow)) {
            $this->_redis->hset("rate:{$ip}", "tries", 1);
            $this->_redis->hset("rate:{$ip}", "last", microtime(true));

            return;
        }

        // TODO : Finish this.
    }

    /**
     * Check the user's IP address against Redis, to see if they have been locked.
     *
     * @param null|WP_User|WP_Error $user
     * @param string $username
     * @param string $password
     *
     * @return WP_Error|WP_User
     */
    public function checkUserIp($user, $username, $password)
    {
        $redisRow = $this->_redis->hgetall("rate:" . self::getUserIp());

        if (is_array($redisRow) && isset($redisRow["locked"]) && $redisRow["locked"] === "1") {
            return new WP_Error("bb_lrlr_account_locked", __("Your IP address has been banned because of too many failed login attempts. Please try again later."));
        }

        return $user;

    }

    /**
     * Get the user's IP address.
     *
     * @return string
     */
    public static function getUserIp()
    {
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
            return $_SERVER['HTTP_CLIENT_IP'];
        }
        if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            return $_SERVER['HTTP_X_FORWARDED_FOR'];
        }

        return $_SERVER['REMOTE_ADDR'];
    }
}
