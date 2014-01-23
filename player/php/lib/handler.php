<?php

require_once 'api/API/PlayerStrategy.php';

class PlayerHandler implements \API\PlayerStrategyIf
{
  public function name()
  {
    return "PHilip Potts";
  }


  public function bet_request($pot, \API\BetLimits $limits)
  {
    return 0;
  }

  public function competitor_status(\API\Competitor $competitor)
  {
  }

  public function bet(\API\Competitor $competitor, \API\Bet $bet)
  {
  }

  public function hole_card(\API\Card $card)
  {
  }

  public function community_card(\API\Card $card)
  {
  }

  public function showdown(\API\Competitor $competitor, $cards, \API\HandDescriptor $hand)
  {
  }

  public function winner(\API\Competitor $competitor, $amount)
  {
  }

  public function shutdown()
  {
  }
}