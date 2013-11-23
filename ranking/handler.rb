$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require_relative 'lib/api/ranking'

module Ranking
  class Handler
    def rank_hand cards
      API::HandDescriptor.new
    end
  end
end
