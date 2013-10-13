class Croupier::GameSteps::IntroducePlayers
  def run(game_state)
    game_state.send_message_to_everyone do |player|
      game_state.players.each do |competitor|
        player.competitor_status competitor
      end
    end
  end
end