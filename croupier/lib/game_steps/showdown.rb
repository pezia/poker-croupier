
require 'card'
require 'ranking/hand'

class Croupier::GameSteps::Showdown < Croupier::GameSteps::Base
  def run
    winners = []
    best_hand = Ranking::Hand.new

    game_state.each_player do |player|
      unless player.active?
        next
      end

      hand = Ranking::Hand.new *game_state.community_cards, *player.hole_cards
      if best_hand.defeats? hand
        next
      end

      winners = [] if hand.defeats? best_hand

      winners << player
      best_hand = hand
    end

    game_state.each_observer do |player|
      winners.each do |winner|
        player.winner winner
      end
    end
  end
end
