class Croupier::Player
  attr_accessor :stack
  attr_reader :hole_cards

  attr_accessor :total_bet

  def initialize(strategy)
    @strategy = strategy
    @stack = 1000
    @active = true
    @allin = false
    @forced_bet = nil
    @hole_cards = []
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

  def allin
    @allin = true
  end

  def allin?
    @allin
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