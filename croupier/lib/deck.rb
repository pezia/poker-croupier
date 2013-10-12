require 'card'

class Croupier::Deck
  def initialize
    shuffle
  end

  def next_card!
    id = @permutation.pop

    return Card.new id unless id.nil?
  end

  def shuffle
    @permutation = (0.upto 51).to_a.shuffle
  end
end