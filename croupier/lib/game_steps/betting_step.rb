class Croupier::GameSteps::BettingStep < Croupier::GameSteps::Base
  def run

    @betting_state = build_betting_state

    @betting_players = 0.upto(@game_state.players.length - 1).map do |player|
      Croupier::GameSteps::Betting::Player.new @betting_state, player
    end

    in_action = 1
    until betting_is_over? && in_action > @betting_players.length
      @betting_players[in_action % (@betting_players.length)].take_turn
      in_action = in_action + 1
    end
  end

  private

  def build_betting_state
    Croupier::GameSteps::Betting::State.new game_state
  end

  def betting_is_over?
    @betting_players.each do |player|
      if player.active? && (!player.allin?) && player.total_bet != @betting_state.game_state.current_buy_in
        return false
      end
    end
    true
  end


end
