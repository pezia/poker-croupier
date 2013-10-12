$:.push(File.join(File.dirname(__FILE__), '../../common/lib'))

require_relative '../croupier'

class MakeGameState
  def self.with(options)
    game_state = Croupier::GameState.new
    players = options[:players] || []
    spectators = options[:spectators] || []

    players.each do |player|
      game_state.register_player(player)
    end
    spectators.each do |spectator|
      game_state.register_spectator(spectator)
    end
    game_state
  end
end

class DummyClass
  def method_missing(method, *args)

  end
end