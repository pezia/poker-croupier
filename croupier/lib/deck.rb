require 'card'

class Croupier::Deck
  def initialize
    reset
  end

  def next_card
    id = @permutation.pop

    return Card.new id unless id.nil?
  end

  def reset
    @permutation = (0.upto 52).to_a.shuffle
  end
end