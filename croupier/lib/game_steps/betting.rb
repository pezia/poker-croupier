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
    until betting_is_over? in_action
      @betting_players[in_action].take_turn
      in_action = (in_action + 1) % (@betting_players.length)
    end
  end

  private


  def betting_is_over?(in_action)
    @betting_state.last_raise == in_action
  end


end
