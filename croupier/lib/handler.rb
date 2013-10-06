
require_relative 'player_builder'
require_relative 'croupier'

class Croupier::Handler
  def initialize
    @croupier = Croupier::Croupier.new
  end

  def register_player(host, port)
    @croupier.register_player Croupier::PlayerBuilder.new.build_player(host,port)
  end


  def register_spectator(host, port)

  end

  def start_sit_and_go
    @croupier.start_sit_and_go
  end

end