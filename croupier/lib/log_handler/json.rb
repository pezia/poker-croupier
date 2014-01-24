require 'json'

class Croupier::LogHandler::Json

  def initialize(file)
    @history = []
    @file = file
  end

  def initialize_state
    @game_phase = :start
    @state = {
        pot: 0,
        community_cards: [],
        players: [],
    }
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
    @state[:players][@player_index[competitor.name]][:hole_cards] << format_card(card)
    save_step
  end

  def format_card(card)
    rank = card.value
    if card.value > 10
      rank = ["J","Q","K","A"][card.value - 11]
    end
    {rank: rank, suit: card.suit.downcase}
  end

  def save_step
    @history << JSON.generate(@state)
  end

  def community_card(card)
    @state[:community_cards] << format_card(card)
    save_step
  end

  def bet(competitor, bet)
    @state[:pot] = bet[:pot]
    @state[:players][@player_index[competitor.name]][:stack] = competitor.stack
    @state[:players][@player_index[competitor.name]][:bet] = bet[:amount]
    @state[:players][@player_index[competitor.name]][:status] = "folded" if bet[:type] == :fold
    save_step
  end

  def showdown(competitor, hand)
  end

  def winner(competitor, amount)
    @game_phase = :end
    @state[:pot] -= amount
    @state[:players][@player_index[competitor.name]][:stack] += amount
    save_step
  end

  def shutdown
    File.open(@file, 'w') do |file|
      file.puts "[" + @history.join(',') + "]"
    end
  end
end
