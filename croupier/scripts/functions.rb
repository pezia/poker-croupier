$:.push('../lib/api')

Dir.chdir File.dirname(__FILE__)

require 'thrift'
require 'croupier'

def connect_server
  transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9090))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = API::Croupier::Client.new(protocol)

  transport.open()
  [client, transport]
end

def start_server(log_file)
  croupier = fork do
    exec "bundle exec ruby ../croupier_service.rb | tee #{log_file}"
  end
  Process.detach(croupier)

  sleep(2)
end

def sit_and_go(log_file, &block)
  start_server log_file

  client, transport = connect_server

  client.instance_eval &block

  client.start_sit_and_go
  client.shutdown
  transport.close
end
