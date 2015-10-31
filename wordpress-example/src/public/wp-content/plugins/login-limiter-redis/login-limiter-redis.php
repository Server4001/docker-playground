<?php
/*
Plugin Name: Login Rate Limiter - Redis
Plugin URI: TBD
Description: Limits the rate of user login, using Redis as the data store, preventing MySQL from crashing.
Author: Brice Bentler
Version: 0.1.0
Text Domain: redis-limiter
Author URI: http://www.bricebentler.com
License: MIT
*/

define("BB_LRLR_PROJECT_ROOT", dirname(dirname(WP_CONTENT_DIR)));

require BB_LRLR_PROJECT_ROOT . "/vendor/autoload.php";

use LoginLimiter\SetupHooks;
use Predis\Client;

$redis = new Client(array(
    'scheme' => 'tcp',
    'host'   => 'redis',
    'port'   => 6379,
));

$hooks = new SetupHooks($redis);
