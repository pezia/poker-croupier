<?php

class DefaultPokerStrategy {

    public function calculateBet($pot, \API\BetLimits $limits, PlayerHandler $handler) {
        $ranking = $handler->getFullRanking();
        $normalizedRanking = $handler->getNormalizedRanking();

       /* if ((!$handler->hasFlop()) && $ranking === 1) {
            return $handler->getStack() / 2;
        }*/

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
            case $ranking <= 5 && $ranking >= 3:
                if ($normalizedRanking == 0) {
                    if ($handler->isRiver()) {
                        return 0;
                    }

                    if (!$handler->hasFlop() && $limits->to_call < ($handler->getStack() / 5)) {
                        return $limits->to_call;
                    }

                    if ($limits->to_call < ($handler->getStack() / 10)) {
                        return $limits->to_call;
                    }

                    return 0;
                } else {
                    if ($limits->minimum_raise < ($handler->getStack() / 5)) {
                        return $limits->minimum_raise + ($normalizedRanking * 30);
                    } else {
                        return $limits->to_call;
                    }
                }
                break;
            case $ranking <= 2 && $ranking >= 1:
                if ($normalizedRanking == 0) {
                    if ($handler->isRiver()) {
                        return 0;
                    }

                    if (!$handler->hasFlop() && $limits->to_call < ($handler->getStack() / 5)) {
                        return $limits->to_call;
                    }

                    if ($limits->to_call < ($handler->getStack() / 10)) {
                        return $limits->to_call;
                    }

                    return 0;
                } else {
                    return $limits->to_call;
                }
                break;
            case $ranking == 0:
                return 0;
            default:
                break;
        }
    }

}
