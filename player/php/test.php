<?php

error_reporting(E_ALL);

require_once __DIR__.'/lib/api/Thrift/ClassLoader/ThriftClassLoader.php';
require_once __DIR__ . '/lib/handler.php';

use Thrift\ClassLoader\ThriftClassLoader;

$GEN_DIR = realpath(dirname(__FILE__)).'/lib/api';

$loader = new ThriftClassLoader();
$loader->registerNamespace('Thrift', __DIR__ . '/lib/api');
$loader->registerDefinition('shared', $GEN_DIR);
$loader->registerDefinition('API', $GEN_DIR);
$loader->register();


if (php_sapi_name() == 'cli') {
  ini_set("display_errors", "stderr");
}

use Thrift\Protocol\TBinaryProtocol;
use Thrift\Transport\TPhpStream;
use Thrift\Transport\TBufferedTransport;

header('Content-Type', 'application/x-thrift');
if (php_sapi_name() == 'cli') {
  echo "\r\n";
}

$handler = new PlayerHandler();
$handler->status = array();
$handler->shutdown();

$cards = array(
    new API\Card(array('value' => 4, 'suite' => \API\Suit::Clubs)),
    new API\Card(array('value' => 2, 'suite' => \API\Suit::Clubs)),
    new API\Card(array('value' => 3, 'suite' => \API\Suit::Clubs)),
    new API\Card(array('value' => 1, 'suite' => \API\Suit::Clubs)),
);

$handler->orderCards($cards);


$handler->hole_card(new API\Card(array('value' => 1, 'suite' => \API\Suit::Clubs)));
$handler->hole_card(new API\Card(array('value' => 2, 'suite' => \API\Suit::Clubs)));

$handler->community_card(new API\Card(array('value' => 3, 'suite' => \API\Suit::Clubs)));
$handler->community_card(new API\Card(array('value' => 4, 'suite' => \API\Suit::Clubs)));

$out = $handler->getHighCard();

print_r($handler->getRanking());
