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

    // The number of the Redis database.
    const RATE_LIMIT_REDIS_DB = 2;

    // The maximum number of login attempts, where we lock the account.
    const MAX_LOGIN_ATTEMPTS = 3;

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
        add_filter('wp_authenticate_user', array($this, 'handleUserAuth'), 10, 2);

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

    }

    /**
     * Handles authenticating a user, and updating Redis.
     * 
     * @param WP_User|WP_Error $user
     * @param string $password
     *
     * @return WP_User|WP_Error
     */
    public function handleUserAuth($user, $password)
    {
        $redisRow = $this->_redis->hgetall("rate:" . $user->user_login);
        if (is_array($redisRow) && isset($redisRow["locked"]) && $redisRow["locked"] === "1") {
            return new WP_Error("bb_lrlr_account_locked", "Your account has been locked. TODO : Provide user with way to unlock account.");
        }

        return $user;
    }
}
