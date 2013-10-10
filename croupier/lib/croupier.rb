
class Croupier::Croupier
  attr_reader :small_blind
  attr_reader :big_blind

  def initialize
    @players = []
    @small_blind = 10
    @big_blind = 20
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

    force_bet(@players[0], small_blind)
    force_bet(@players[1], big_blind)

    deck = Croupier::Deck.new

    0.upto(1).each do |_|
      @players.each do |player|
        player.hole_card deck.next_card
      end
    end
  end

  def force_bet(betting_player, bet_amount)
    bet = Croupier::Bet.new
    bet.amount = bet_amount
    bet.type = :blind
    @players.each do |player|
      player.bet(betting_player, bet)
    end
  end
end