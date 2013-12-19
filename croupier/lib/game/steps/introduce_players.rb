class Croupier::Game::Steps::IntroducePlayers < Croupier::Game::Steps::Base
  def run
    game_state.each_observer do |player|
      game_state.players.each do |competitor|
        player.competitor_status competitor
      end
    end
  end
end