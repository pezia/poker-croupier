class Croupier::GameState
  attr_reader :players
  attr_reader :spectators
  attr_reader :small_blind
  attr_reader :big_blind
  attr_accessor :pot

  def initialize
    @players = []
    @spectators = []
    @small_blind = 10
    @big_blind = 20
    @pot = 0
  end

  def register_player(player)
    @players << player
  end

  def register_spectator(spectator)
    @spectators << spectator
  end

  def deck
    @deck ||= Croupier::Deck.new
  end

  def send_community_message
    (@players + @spectators).each do |observer|
      yield observer
    end
  end

  def send_private_message_to(player)
    yield player
    @spectators.each do |observer|
      yield observer
    end
  end
end