
require 'card'
require 'ranking/hand'

class Croupier::GameSteps::Showdown < Croupier::GameSteps::Base
  def run
    find_winner
    announce
    award
  end

  private

  def find_winner
    @winners = []
    @best_hand = Ranking::Hand.new

    game_state.each_player do |player|
      examine_cards_of player
    end
  end

  def examine_cards_of(player)
    return unless player.active?

    hand = Ranking::Hand.new *game_state.community_cards, *player.hole_cards
    return if @best_hand.defeats? hand

    @winners = [] if hand.defeats? @best_hand

    @winners << player
    @best_hand = hand
  end

  def announce
    game_state.each_observer do |player|
      @winners.each do |winner|
        player.winner winner
      end
    end
  end

  def award
    total_pot = game_state.pot
    remainder = total_pot % @winners.length
    @winners.each_with_index do |winner, index|
      game_state.transfer winner, -(total_pot / @winners.length).floor - (index < remainder ? 1 : 0)
    end
  end
end
