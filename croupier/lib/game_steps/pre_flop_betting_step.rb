
class Croupier::GameSteps::PreFlopBettingStep < Croupier::GameSteps::Betting::Step

  private

  def build_betting_state
    game_state.first_player.force_bet game_state.small_blind
    game_state.second_player.force_bet game_state.big_blind
    Croupier::GameSteps::Betting::State.new(game_state).tap do |state|
      state.minimum_raise = 0
    end
  end

end