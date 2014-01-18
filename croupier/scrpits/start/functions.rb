
require 'thrift'
require 'croupier'

def connect_server
  transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9090))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = API::Croupier::Client.new(protocol)

  transport.open()
  client
end

def start_server(log_file)
  croupier = fork do
    exec "bundle exec ruby ../croupier_service.rb | tee #{log_file}"
  end
  Process.detach(croupier)

  sleep(2)
end