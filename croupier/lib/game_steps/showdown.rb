
require 'card'
require 'ranking/hand'

class Croupier::GameSteps::Showdown < Croupier::GameSteps::Base
  def run
    winners = find
    announce(winners)
    award(winners)
  end

  private

  def find
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
    winners
  end

  def announce(winners)
    game_state.each_observer do |player|
      winners.each do |winner|
        player.winner winner
      end
    end
  end

  def award(winners)
    total_pot = game_state.pot
    remainder = total_pot % winners.length
    winners.each_with_index do |winner, index|
      game_state.transfer winner, -(total_pot / winners.length).floor - (index < remainder ? 1 : 0)
    end
  end
end
