#!/usr/bin/env php
<?php

error_reporting(E_ALL);

require_once __DIR__.'/lib/api/Thrift/ClassLoader/ThriftClassLoader.php';
require_once 'lib/handler.php';

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

$handler = new \PlayerHandler();
$processor = new \API\PlayerStrategyProcessor($handler);

$transport = new TBufferedTransport(new TPhpStream(TPhpStream::MODE_R | TPhpStream::MODE_W));
$protocol = new TBinaryProtocol($transport, true, true);

$transport->open();
$processor->process($protocol, $protocol);
$transport->close();