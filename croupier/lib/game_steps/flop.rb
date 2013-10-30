class Croupier::GameSteps::Flop < Croupier::GameSteps::Base
  def run
    3.times do
      card = game_state.deck.next_card!
      game_state.each_player_and_spectator do |observer|
        observer.community_card(card)
      end
    end
  end

end
