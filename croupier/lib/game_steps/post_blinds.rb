class Croupier::GameSteps::PostBlinds
  def run(game_state)
    game_state.players[0].stack -= game_state.small_blind
    game_state.players[1].stack -= game_state.big_blind
    game_state.pot += game_state.small_blind + game_state.big_blind
    game_state.each_player_and_spectator do |player|
      player.bet game_state.players[0], amount: game_state.small_blind, type: :blind
      player.bet game_state.players[1], amount: game_state.big_blind, type: :blind
    end
  end
end
