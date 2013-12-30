class Croupier::Tournament::Runner

  def initialize
    @tournament_state = Croupier::Tournament::State.new
  end

  def register_player(player)
    @tournament_state.register_player player
  end

  def register_spectator(spectator)
    @tournament_state.register_spectator spectator
  end

  def start_sit_and_go
    while @tournament_state.number_of_active_players_in_tournament >= 2 do
      Croupier::Game::Runner.new.run(@tournament_state)
      @tournament_state.next_round!
    end
  end

end
