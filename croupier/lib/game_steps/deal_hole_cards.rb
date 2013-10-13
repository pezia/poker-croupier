class Croupier::GameSteps::DealHoleCards
  def run(game_state)
    deal_one_card_to_each_player(game_state)
    deal_one_card_to_each_player(game_state)
  end

  private

  def deal_one_card_to_each_player(game_state)
    game_state.players.each do |player|
      next_card = game_state.deck.next_card!
      player.hole_card(next_card)
      game_state.each_spectator do |observer|
        observer.hole_card(player, next_card)
      end
    end
  end
end