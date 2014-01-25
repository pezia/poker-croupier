<?php

use \Thrift\Transport\TPhpStream;

require_once 'api/API/PlayerStrategy.php';

class PlayerHandler implements \API\PlayerStrategyIf {

    const STATE_FILE = '/tmp/poker_status';

    public $status = array();

    public function __construct() {
        if (is_readable(self::STATE_FILE)) {
            $this->status = unserialize(file_get_contents(self::STATE_FILE));
        }
    }

    public function name() {
        return "Korda György";
    }

    /**
     *  8: HandType::StraightFlush, 
     *  7: HandType::FourOfAKind,
     *  6: HandType::FullHouse,
     *  5: HandType::Flush, 
     *  4: HandType::Straight,
     *  3: HandType::ThreeOfAKind,
     *  2: HandType::TwoPair,
     *  1: HandType::Pair,
     *  0: HandType::HighCard
     */
    public function bet_request($pot, \API\BetLimits $limits) {
        $this->shutdown();

        $ranking = $this->getFullRanking();
        $normalizedRanking = $this->getNormalizedRanking();

        switch (true) {
            case $ranking > 7:
                return $limits->minimum_raise + 2000;
            case $ranking == 7:
            case $ranking == 6:
                if ($normalizedRanking > 0) {
                    return $limits->minimum_raise + 200;
                } else {
                    return $limits->to_call;
                }
                break;
            case $ranking <= 5 && $ranking >= 1:
                if ($normalizedRanking == 0) {
                    if($this->hasRiver()) {
                        return 0;
                    }
                    
                    if (!$this->hasFlop() && $limits->to_call < $this->status['stack'] / 2) {
                        return $limits->to_call;
                    }
                    
                    if($limits->to_call < $this->status['stack'] / 2) {
                        return $limits->to_call;
                    }

                    return 0;
                } else {
                    if($limits->minimum_raise < 200) {
                        return $limits->minimum_raise + ($normalizedRanking * 10);
                    } else {
                        return $limits->to_call;
                    }
                }
                break;
            case $ranking == 0:
                return 0;
            default:
                break;
        }
    }

    public function competitor_status(\API\Competitor $competitor) {
        if ($this->name() === $competitor->name) {
            $this->status['stack'] = $competitor->stack;
        }
        $this->shutdown();
    }

    public function bet(\API\Competitor $competitor, \API\Bet $bet) {
        if ($this->name() === $competitor->name) {
            $this->status['stack'] = $competitor->stack;
        }
        $this->shutdown();
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
        file_put_contents(self::STATE_FILE, serialize($this->status));
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

    public function getFullRanking() {
        if (!isset($this->status['cards'])) {
            $ret = new \API\HandDescriptor();
            $ret->ranks = array(0);
            return $ret;
        }

        $transport = new \Thrift\Transport\TSocket('127.0.0.1', 9080);
        $protocol = new \Thrift\Protocol\TBinaryProtocol($transport);

        $rankingClient = new \API\RankingClient($protocol);
        $transport->open();
        $ret = $rankingClient->rank_hand($this->status['cards']);
        $transport->close();

        return $ret;
    }

    public function getCommunityRanking() {
        if (!isset($this->status['community_cards'])) {
            $ret = new \API\HandDescriptor();
            $ret->ranks = array(0);
            return $ret;
        }

        $transport = new \Thrift\Transport\TSocket('127.0.0.1', 9080);
        $protocol = new \Thrift\Protocol\TBinaryProtocol($transport);

        $rankingClient = new \API\RankingClient($protocol);
        $transport->open();
        $ret = $rankingClient->rank_hand($this->status['community_cards']);
        $transport->close();

        return $ret;
    }

    public function getNormalizedRanking() {
        $fullRanking = $this->getFullRanking();
        $communityRanking = $this->getCommunityRanking();

        return $fullRanking->ranks[0] - $communityRanking->ranks[0];
    }

    public function hasFlop() {
        return isset($this->status['community_cards']) && count($this->status['community_cards']) >= 3;
    }
    
    
    public function hasRiver() {
        return isset($this->status['community_cards']) && count($this->status['community_cards']) >= 5;
    }

}
