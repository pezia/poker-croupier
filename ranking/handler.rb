$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require_relative 'lib/api/ranking'
require 'card'
require 'ranking/hand'

module Ranking
  class Handler
    def rank_hand(api_cards)
      cards = api_cards.map do |api_card|
        if api_card.value.nil? or api_card.suit.nil?
          Card.new api_card.name
        else
          Card.new (api_card.value - 2) + api_card.suit * 13
        end

      end

      hand = Hand.new(*cards)

      API::HandDescriptor.new.tap do |descriptor|
        descriptor.name = hand.name
        descriptor.ranks = [hand.rank, hand.value, hand.second_value, *hand.kickers]
      end
    end
  end
end
