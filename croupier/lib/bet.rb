class Croupier::Bet
  attr_accessor :amount
  attr_accessor :type

  def ==(other)
    @amount == other.amount && @type == other.type
  end
end