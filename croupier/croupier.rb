$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require_relative 'lib/api/croupier'

module Croupier

  autoload :Deck, 'lib/deck'
  autoload :GameRunner, 'lib/game_runner'
  autoload :GameState, 'lib/game_state'
  autoload :GameSteps, 'lib/game_steps'
  autoload :Handler, 'lib/handler'
  autoload :Player, 'lib/player'
  autoload :PlayerBuilder, 'lib/player_builder'
  autoload :Spectator, 'lib/spectator'
  autoload :SpectatorBuilder, 'lib/spectator_builder'
  autoload :TestFramework, 'lib/test_framework'

  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end

