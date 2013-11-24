class Croupier::GameSteps::DealHoleCards < Croupier::GameSteps::Base
  def run
    deal_one_card_to_each_player
    deal_one_card_to_each_player
  end

  private

  def deal_one_card_to_each_player
    game_state.each_player do |player|
      next_card = game_state.deck.next_card!
      player.hole_card(next_card)
      game_state.each_spectator do |observer|
        observer.hole_card(player, next_card)
      end
    end
  end
end