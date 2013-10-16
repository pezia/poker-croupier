class SpecHelper::MakeGameState
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