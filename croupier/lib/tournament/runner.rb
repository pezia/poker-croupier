class Croupier::Tournament::Runner

  include Croupier::Game::Steps
  GAME_STEPS = [
      IntroducePlayers,
      ShuffleCards,
      DealHoleCards,
      Betting::PreFlop,
      DealFlop,
      Betting::Step,
      DealTurnCard,
      Betting::Step,
      DealRiverCard,
      Betting::Step,
      Showdown
  ]

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
    while @tournament_state.number_of_players_in_game >= 2 do
      game_state = Croupier::Game::State.new(@tournament_state)
      GAME_STEPS.each do |step_type|
        step_type.new(game_state).run
      end
      @tournament_state.next_round!
    end
  end

end
