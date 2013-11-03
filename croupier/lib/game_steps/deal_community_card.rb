
class Croupier::GameSteps::DealCommunityCard < Croupier::GameSteps::Base
  def run
    card = game_state.deck.next_card!
    game_state.community_cards << card
    game_state.each_observer do |observer|
      observer.community_card(card)
    end
  end
end