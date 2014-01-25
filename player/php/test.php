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
    new API\Card(array('value' => 4, 'suite' => \API\Suit::Clubs, 'name' => '4 of Clubs')),
    new API\Card(array('value' => 2, 'suite' => \API\Suit::Clubs, 'name' => '2 of Clubs')),
    new API\Card(array('value' => 3, 'suite' => \API\Suit::Clubs, 'name' => '3 of Clubs')),
    new API\Card(array('value' => 1, 'suite' => \API\Suit::Clubs, 'name' => '1 of Clubs')),
);

$handler->orderCards($cards);


/*$handler->hole_card(new API\Card(array('value' => 2, 'suite' => \API\Suit::$__names[\API\Suit::Clubs], 'name' => '2 of Clubs')));
$handler->hole_card(new API\Card(array('value' => 3, 'suite' => \API\Suit::$__names[\API\Suit::Spades], 'name' => '2 of Spades')));

$handler->community_card(new API\Card(array('value' => 2, 'suite' => \API\Suit::$__names[\API\Suit::Clubs], 'name' => '3 of Clubs')));
$handler->community_card(new API\Card(array('value' => 3, 'suite' => \API\Suit::$__names[\API\Suit::Spades], 'name' => '3 of Spades')));
$handler->community_card(new API\Card(array('value' => 4, 'suite' => \API\Suit::$__names[\API\Suit::Clubs], 'name' => '4 of Clubs')));

 */

$handler->hole_card(new API\Card(array('value' => 6, 'suite' => \API\Suit::$__names[\API\Suit::Diamonds], 'name' => '6 of Diamonds')));
$handler->hole_card(new API\Card(array('value' => 10, 'suite' => \API\Suit::$__names[\API\Suit::Diamonds], 'name' => '10 of Diamonds')));

//$handler->community_card(new API\Card(array('value' => 10, 'suite' => \API\Suit::$__names[\API\Suit::Spades], 'name' => 'Jack of Spades')));
//$handler->community_card(new API\Card(array('value' => 3, 'suite' => \API\Suit::$__names[\API\Suit::Diamonds], 'name' => '3 of Diamonds')));
//$handler->community_card(new API\Card(array('value' => 4, 'suite' => \API\Suit::$__names[\API\Suit::Hearts], 'name' => '4 of Hearts')));
//$handler->community_card(new API\Card(array('value' => 10, 'suite' => \API\Suit::$__names[\API\Suit::Clubs], 'name' => 'Jack of Clubs')));

//$handler->getHighCard();

$out = $handler->getCommunityRanking();
print_r($out);

$out = $handler->getFullRanking();
print_r($out);

$out = $handler->getNormalizedRanking();
print_r($out);
