class Croupier::GameSteps::Betting < Croupier::GameSteps::Base
  def run

    @betting_state = Croupier::GameSteps::BettingState.new game_state

    @betting_players = 0.upto(@game_state.players.length - 1).map do |player|
      Croupier::GameSteps::BettingPlayer.new @betting_state, player
    end

    @betting_players.each_index do |in_action|
      @betting_players[in_action].take_turn
    end

    in_action = 0
    until betting_is_over?
      @betting_players[in_action].take_turn
      in_action = (in_action + 1) % (@betting_players.length)
    end
  end

  private


  def betting_is_over?
    @betting_players.each do |player|
      if player.active? && (!player.allin?) && player.total_bet != @betting_state.current_buy_in
        return false
      end
    end
    true
  end


end
