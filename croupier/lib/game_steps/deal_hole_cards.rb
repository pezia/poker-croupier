class Croupier::GameSteps::DealHoleCards
  def run(game_state)
    deal_one_card_to_each_player(game_state)
    deal_one_card_to_each_player(game_state)
  end

  private

  def deal_one_card_to_each_player(game_state)
    game_state.players.each do |player|
      player.hole_card(game_state.deck.next_card)
    end
  end
end