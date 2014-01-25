<?php

class Ranker {

    public function getRankingForCards($cards) {
        $transport = new \Thrift\Transport\TSocket('127.0.0.1', 9080);
        $protocol = new \Thrift\Protocol\TBinaryProtocol($transport);

        $rankingClient = new \API\RankingClient($protocol);
        $transport->open();
        $ret = $rankingClient->rank_hand($cards);
        $transport->close();

        return $ret;
    }

}
