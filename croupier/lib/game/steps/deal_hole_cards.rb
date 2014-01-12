class Croupier::Game::Steps::DealHoleCards < Croupier::Game::Steps::Base
  def run
    deal_one_card_to_each_player
    deal_one_card_to_each_player
  end

  private

  def deal_one_card_to_each_player
    game_state.each_player_from game_state.first_player do |player|
      if player.has_stack?
        next_card = game_state.deck.next_card!
        player.hole_card(next_card)
        game_state.each_spectator do |observer|
          observer.hole_card(player, next_card)
        end
      end
    end
  end
end