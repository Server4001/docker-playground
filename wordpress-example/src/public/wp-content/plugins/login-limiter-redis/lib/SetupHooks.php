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

class SetupHooks
{

    /**
     * Override the default constructor, so that actions and filters can be hooked into.
     */
    public function __construct()
    {
        add_action('login_head', array($this, 'renderErrorMessage'));
        add_action('wp_login_failed', array($this, 'handleFailedLogin'));
        add_filter('wp_authenticate_user', array($this, 'handleUserAuth'), 10, 2);
    }

    /**
     * Renders an error message to the login page.
     */
    public function renderErrorMessage()
    {

    }

    /**
     * Handles a failed login, updating Redis.
     *
     * @param string $username
     */
    public function handleFailedLogin($username)
    {

    }

    /**
     * Handles authenticating a user, and updating Redis.
     * 
     * @param \WP_User|\WP_Error $user
     * @param string $password
     *
     * @return \WP_User|\WP_Error
     */
    public function handleUserAuth($user, $password)
    {
        return $user;
    }
}
