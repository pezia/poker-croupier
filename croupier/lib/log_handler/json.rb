require 'json'

class Croupier::LogHandler::Json

  def initialize(file)
    @file = file
  end

  def initialize_state
    @game_phase = :start
    @state = {
        pot: 0,
        community_cards: [],
        players: [],
    }
    @history = []
    @player_index = {}
  end

  def competitor_status(competitor)
    unless @game_phase == :start
      initialize_state
    end

    @game_phase = :start
    @player_index[competitor.name] = @state[:players].length
    @state[:players] << {
        name: competitor.name,
        stack: competitor.stack,
        bet: 0,
        status: ((competitor.stack > 0) ? 'active' : 'out'),
        hole_cards: []
    }
  end

  def hole_card(competitor, card)
    @state[:players][@player_index[competitor.name]][:hole_cards] << { value: card.value, suit: card.suit }
    @history << @state
  end

  def community_card(card)
    @state[:community_cards] << { value: card.value, suit: card.suit }
    @history << @state
  end

  def bet(competitor, bet)
    @state[:pot] = bet[:pot]
    @state[:players][@player_index[competitor.name]][:stack] = competitor.stack
    @state[:players][@player_index[competitor.name]][:bet] = bet[:amount]
    @state[:players][@player_index[competitor.name]][:folded] = true if bet[:type] == :fold
    @history << @state
  end

  def showdown(competitor, hand)
  end

  def winner(competitor, amount)
    @game_phase = :end
    @state[:pot] -= amount
    @state[:players][@player_index[competitor.name]][:stack] += amount
    @history << @state
  end

  def shutdown
    File.open(@file, 'w') do |file|
      file.puts JSON.generate(@history)
    end
  end
end
