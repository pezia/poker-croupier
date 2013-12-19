$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require_relative 'lib/api/croupier'

module Croupier

  autoload :Deck, 'lib/deck'
  autoload :GameRunner, 'lib/game_runner'
  autoload :GameState, 'lib/game_state'
  autoload :Game, 'lib/game'
  autoload :Handler, 'lib/handler'
  autoload :LogHandler, 'lib/log_handler'
  autoload :Player, 'lib/player'
  autoload :PlayerStrategy, 'lib/player_strategy'
  autoload :PlayerBuilder, 'lib/player_builder'
  autoload :Spectator, 'lib/spectator'
  autoload :SpectatorBuilder, 'lib/spectator_builder'
  autoload :ThriftEntityGateway, 'lib/thrift_entity_gateway'
  autoload :ThriftObserver, 'lib/thrift_observer'

  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end

