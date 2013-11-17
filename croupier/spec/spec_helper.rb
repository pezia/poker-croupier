$:.push(File.join(File.dirname(__FILE__), '../../common/lib'))
$:.push(File.join(File.dirname(__FILE__)))

require_relative '../croupier'
require_relative '../../croupier/lib/api/types_types'

module SpecHelper
  autoload :DummyClass, 'spec_helper/dummy_class'
  autoload :FakeStrategy, 'spec_helper/fake_strategy'
  autoload :FakeSpectator, 'spec_helper/fake_spectator'
  autoload :MakeGameState, 'spec_helper/make_game_state'
end

def fake_player
  Croupier::Player.new SpecHelper::FakeStrategy.new
end
