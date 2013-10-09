
class Croupier::Croupier
  def initialize
    @players = []
  end

  def register_player(player)
    @players.push player
  end

  def start_sit_and_go
    @players.each do |other_player|
      @players.each do |player|
        player.competitor_status(other_player)
      end
    end

    deck = Croupier::Deck.new

    0.upto(1).each do |_|
      @players.each do |player|
        card = deck.next_card
        p card
        player.hole_card card.value, card.suit
      end
    end
  end
end