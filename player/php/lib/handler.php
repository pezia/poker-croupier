<?php

use \Thrift\Transport\TPhpStream;

require_once 'api/API/PlayerStrategy.php';

class PlayerHandler implements \API\PlayerStrategyIf {

    public $status = array();

    public function __construct() {
        if (is_readable('/tmp/poker_status')) {
            $this->status = unserialize(file_get_contents('/tmp/poker_status'));
        }
    }

    public function name() {
        return "Korda György";
    }

    public function bet_request($pot, \API\BetLimits $limits) {
        $this->shutdown();
        $random = mt_rand(0, 100);
        if ($random < 50) {
            return $limits->to_call;
        } else if ($random < 5) {
            return 0;
        } else {
            return $limits->minimum_raise + mt_rand(1, 20);
        }
    }

    public function competitor_status(\API\Competitor $competitor) {
        $this->shutdown();
    }

    public function bet(\API\Competitor $competitor, \API\Bet $bet) {
        $this->shutdown();
        return \API\BetType::Call;
    }

    public function hole_card(\API\Card $card) {
        $this->status['hole_cards'][] = $card;
        $this->status['cards'][] = $card;
        $this->orderCards($this->status['cards']);
        $this->shutdown();
    }

    public function community_card(\API\Card $card) {
        $this->status['community_cards'][] = $card;
        $this->status['cards'][] = $card;
        $this->orderCards($this->status['cards']);
        $this->shutdown();
    }

    public function showdown(\API\Competitor $competitor, $cards, \API\HandDescriptor $hand) {
        $this->shutdown();
    }

    public function winner(\API\Competitor $competitor, $amount) {
        $this->status = array();
        $this->shutdown();
    }

    public function shutdown() {
        file_put_contents('/tmp/poker_status', serialize($this->status));
    }

    public function getHighCard() {
        return isset($this->status['cards'][0]) ? $this->status['cards'][0] : null;
    }

    public function orderCards(&$cards) {
        usort($cards, function (\API\Card $a, \API\Card $b) {
            if ($a->value > $b->value) {
                return -1;
            }

            if ($a->value < $b->value) {
                return 1;
            }
            return 0;
        });
    }

    public function getRanking() {
        $transport = new \Thrift\Transport\TSocket('localhost', 9080);
        $protocol = new \Thrift\Protocol\TBinaryProtocol($transport);

        $rankingClient = new \API\RankingClient($protocol);
        $transport->open();
        $ret = $rankingClient->rank_hand($this->status['cards']);
        $transport->close();

        return $ret;
    }

}
