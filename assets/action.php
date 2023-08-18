<?php
$headers = getallheaders();
$action = $headers['x-msmods'] ?: $headers['X-MSMODS'];
$token = $headers['x-mstoken'] ?: $headers['X-MSTOKEN'];
if(!$token || $token !== $_COOKIE['msmods']) die;

define('MODX_API_MODE', true);
require_once dirname(dirname(__FILE__)) . '/index.php';

$modx->getService('error', 'error.modError');
$modx->setLogLevel(modX::LOG_LEVEL_ERROR);

$res = [];

switch ($action){
    case 'get/modification':
        if($product = $modx->getObject('modResource', ['class_key' => 'msProduct', 'id' => (int)$_POST['id']])){
            $res = $product->toArray();
        }
        break;
}

$res = json_encode($res);
die($res);