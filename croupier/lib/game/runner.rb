class Croupier::Game::Runner

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
    @game_state = Croupier::Game::State.new
  end

  def register_player(player)
    @game_state.register_player player
  end

  def register_spectator(spectator)
    @game_state.register_spectator spectator
  end

  def start_sit_and_go
    while @game_state.players_in_game.length >= 2 do
      GAME_STEPS.each do |step_type|
        step_type.new(@game_state).run
      end
      @game_state.next_round!
    end
  end

end
