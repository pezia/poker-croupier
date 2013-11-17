class Croupier::GameSteps::Betting::State
  attr_accessor :last_raise
  attr_accessor :current_buy_in
  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
    @current_buy_in = 0
    @last_raise = 0
  end

  def players
    @game_state.players
  end

  def transfer_bet(player, bet, bet_type)
    player.total_bet += bet
    @game_state.transfer_bet player, bet, bet_type
  end
end