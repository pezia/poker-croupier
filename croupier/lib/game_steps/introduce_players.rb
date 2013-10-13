class Croupier::GameSteps::IntroducePlayers
  def run(game_state)
    game_state.each_player_and_spectator do |player|
      game_state.players.each do |competitor|
        player.competitor_status competitor
      end
    end
  end
end