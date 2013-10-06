
require_relative 'player_builder'

class Croupier::Handler
  def initialize
    @players = []
  end

  def register_player(host, port)
    @players.push Croupier::PlayerBuilder.new.build_player(host,port)
  end


  def register_spectator(host, port)

  end

  def start_sit_and_go
    @players.each do |player|
      competitor = API::Competitor.new
      competitor.name = player.name
      competitor.stack = player.stack

      @players.each { |other_player| other_player.competitor_status(competitor) }
    end
  end

end