class Croupier::Tournament::State
  attr_reader :players
  attr_reader :spectators

  def initialize
    @players = []
    @spectators = []
    @small_blind = 10
    @number_of_times_button_moved = 0
    @current_player = 0
    @dealers_position = 0
  end

  def small_blind
    @small_blind * (2**(@number_of_times_button_moved/@players.length).floor)
  end

  def big_blind
    small_blind * 2
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

  def each_observer
    (@players + @spectators).each do |observer|
      yield observer
    end
  end

  def each_spectator
    @spectators.each do |observer|
      yield observer
    end
  end

  def each_player
    @players.each do |observer|
      yield observer
    end
  end

  def each_player_from(from_player)
    @players.rotate(@players.index(from_player)).each do |observer|
      yield observer
    end
  end

  def dealer
    @players[@dealers_position]
  end

  def first_player
    @players[nthPlayer 1]
  end

  def second_player
    @players[nthPlayer 2]
  end

  def number_of_active_players_in_tournament
    @players.count { |player| player.has_stack? }
  end

  def players_eliminated
    @players.rotate(@players.index(first_player)).select { |player| not player.has_stack? }
  end

  def active_players
    @players.select { |player| player.has_stack? }
  end

  def next_round!
    @players.each do |player|
      player.initialize_round
    end

    move_deal_button_to_next_active_player
  end

  private

  def move_deal_button_to_next_active_player
    move_deal_button_to_next_player
    until @players[@dealers_position].stack > 0
      move_deal_button_to_next_player
    end
  end

  def move_deal_button_to_next_player
    @dealers_position = nthPlayer 1
    @number_of_times_button_moved += 1
  end

  def nthPlayer(n)
    (@dealers_position + n) % players.count
  end
end
