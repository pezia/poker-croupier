<?php

require_once __DIR__ . '/api/API/PlayerStrategy.php';
require_once __DIR__ . '/DefaultPokerStrategy.php';
require_once __DIR__ . '/Ranker.php';

class PlayerHandler implements \API\PlayerStrategyIf {

    const STATE_FILE = '/tmp/poker_status';

    public $status = array();
    private $ranker;
    private $strategy;

    public function __construct() {
        if (is_readable(self::STATE_FILE)) {
            $this->status = unserialize(file_get_contents(self::STATE_FILE));
        }

        $this->ranker = new Ranker();
        $this->strategy = new DefaultPokerStrategy();
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

        return $this->strategy->calculateBet($pot, $limits, $this);
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

        return $this->ranker->getRankingForCards($this->status['cards']);
    }

    public function getCommunityRanking() {
        if (!isset($this->status['community_cards'])) {
            $ret = new \API\HandDescriptor();
            $ret->ranks = array(0);
            return $ret;
        }

        return $this->ranker->getRankingForCards($this->status['community_cards']);
    }

    public function getNormalizedRanking() {
        $fullRanking = $this->getFullRanking();
        $communityRanking = $this->getCommunityRanking();

        return $fullRanking->ranks[0] - $communityRanking->ranks[0];
    }

    public function hasFlop() {
        return $this->getCommunityCardCount() >= 3;
    }

    public function isTurn() {
        return $this->getCommunityCardCount() == 4;
    }

    public function isRiver() {
        return $this->getCommunityCardCount() == 5;
    }

    public function getCommunityCardCount() {
        return isset($this->status['community_cards']) ? count($this->status['community_cards']) : 0;
    }

    public function getStack() {
        return $this->status['stack'];
    }

}
