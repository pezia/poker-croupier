
class Croupier::Croupier

  include Croupier::GameSteps

  attr_reader :small_blind
  attr_reader :big_blind

  def initialize
    @players = []
    @game_state = Croupier::GameState.new
    @small_blind = 10
    @big_blind = 20
  end

  def register_player(player)
    @players.push player
    @game_state.register_player player
  end

  def start_sit_and_go


    [IntroducePlayers.new, PostBlinds.new].each do |step_type|
      step_type.run(@game_state)
    end

    deck = Croupier::Deck.new

    0.upto(1).each do |_|
      @players.each do |player|
        player.hole_card deck.next_card
      end
    end
  end
end