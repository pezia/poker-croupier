$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require 'player_strategy'

module PlayerStrategy
  autoload :Handler, 'lib/handler'
end
