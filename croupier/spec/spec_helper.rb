$:.push(File.join(File.dirname(__FILE__), '../../common/lib'))

require_relative '../croupier'

class MakeGameState
  def self.with(*players)
    game_state = Croupier::GameState.new
    players.each do |player|
      game_state.register_player(player)
    end
    game_state
  end
end