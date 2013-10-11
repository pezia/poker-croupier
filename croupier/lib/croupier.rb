
class Croupier::Croupier
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
    step = Croupier::GameSteps::IntroducePlayers.new
    step.run(@game_state)

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