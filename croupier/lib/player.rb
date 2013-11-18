class Croupier::Player
  attr_accessor :stack
  attr_reader :hole_cards

  attr_accessor :total_bet

  def initialize(strategy)
    @strategy = strategy
    @stack = 1000
    @forced_bet = nil

    initialize_round
  end

  def initialize_round
    @active = true
    @total_bet = 0
    @hole_cards = []
  end

  def has_stack?
    @stack > 0
  end

  def deposit(amount)
    @stack += amount
  end

  def active?
    @active
  end

  def fold
    @active = false
  end

  def allin?
    @stack == 0
  end

  def force_bet bet
    @forced_bet = bet
  end

  def bet_request
    bet = @forced_bet || @strategy.bet_request
    @forced_bet = nil
    bet
  end

  def hole_card card
    @strategy.hole_card card
    @hole_cards << card
  end

  def method_missing(method, *args)
    @strategy.send(method, *args)
  end
end