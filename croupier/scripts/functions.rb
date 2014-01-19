$:.push('../lib/api')

Dir.chdir File.dirname(__FILE__)

require 'thrift'
require 'croupier'

def connect_server
  transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9090))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = API::Croupier::Client.new(protocol)

  transport.open
  [client, transport]
end

def start_server(log_file)
  croupier = fork do
    exec "bundle exec ruby ../croupier_service.rb #{log_file}"
  end
  Process.detach(croupier)

  sleep(1)
end

def sit_and_go(log_file, &block)
  start_server log_file

  client, transport = connect_server

  client.instance_eval &block

  client.start_sit_and_go
  client.shutdown
  transport.close
end

def start_players(number_of_players)
  player_names = %w(Albert Bob Chuck Daniel Emily Franky George Huge Ivan Joe Kevin Leo Mike Nikki Oliver Peter Q Robert Steve Tom Ulric Victor Walt Xavier Yvette Zara)

  players = []

  player_names[0..number_of_players-1].each_with_index do |player_name, index|
    players[index] = fork do
      exec "bundle exec ruby ../../player/rb/player_service.rb #{9200+index} '#{player_name}'"
    end
  end

  players.each do |player|
    Process.detach(player)
  end
  players
end

def run_timestamp
  Time.now.strftime("%Y_%m_%d_%H_%M_%S")
end