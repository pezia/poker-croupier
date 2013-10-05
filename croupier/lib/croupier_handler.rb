
require_relative 'player_builder'

class CroupierHandler
  def initialize
    @players = []
  end

  def register_player(host, port)
    begin
      player_strategy = PlayerBuilder.new.build_strategy(host,port)

      @players.push player_strategy
    rescue
      puts $!
    end
  end


  def register_spectator(host, port)

  end

  def start_sit_and_go
    @players.each do |player|
      competitor = API::Competitor.new
      competitor.name = player.name
      competitor.stack = 1000

      @players.each { |other_player| other_player.competitor_status(competitor) }
    end
  end

end