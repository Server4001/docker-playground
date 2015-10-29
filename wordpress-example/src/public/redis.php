<?php

define("PROJECT_ROOT", dirname(__DIR__));

require PROJECT_ROOT . "/vendor/autoload.php";

$redis = new Predis\Client([
    'scheme' => 'tcp',
    'host'   => 'redis',
    'port'   => 6379,
]);

$redis->select(8);
$name = $redis->get("name");

echo $name;
