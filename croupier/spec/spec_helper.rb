$:.push(File.join(File.dirname(__FILE__), '../../common/lib'))
$:.push(File.join(File.dirname(__FILE__)))

require_relative '../croupier'

module SpecHelper
  autoload :DummyClass, 'spec_helper/dummy_class'
  autoload :FakeStrategy, 'spec_helper/fake_strategyer'
  autoload :FakeSpectator, 'spec_helper/fake_spectator'
  autoload :MakeGameState, 'spec_helper/make_game_state'
end
