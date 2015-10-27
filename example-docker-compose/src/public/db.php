<?php

try {
    $pdo = new \PDO(
        'mysql:host=db;dbname=demoDb',
        'demoUser',
        'demoPass'
    );
}
catch (\Exception $e) {
    var_dump($e->getMessage());
    die();
}
var_dump($pdo);
