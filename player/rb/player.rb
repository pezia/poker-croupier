$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require 'player_strategy'

module PlayerStrategy
  autoload :Handler, 'lib/handler'
end

#port = ARGV[1]
#
#processor = API::PlayerStrategy::Processor.new(PlayerStrategy::Handler.new())
#transport = Thrift::ServerSocket.new(port)
#server = Thrift::ThreadPoolServer.new(processor, transport)
#server.serve()