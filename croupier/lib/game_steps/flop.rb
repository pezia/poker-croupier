class Croupier::GameSteps::Flop < Croupier::GameSteps::Base
  def run
    cards = Array.new()
    3.times { cards.push(game_state.deck.next_card!) }

    game_state.each_player_and_spectator do |observer|
      cards.each { |card| observer.community_card(card) }
    end
  end

end
