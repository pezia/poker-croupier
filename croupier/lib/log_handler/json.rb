require 'json'

class Croupier::LogHandler::Json

  def initialize(file)
    @history = []
    @file = file
    @dealer = -1
  end

  def initialize_state
    @dealer += 1
    @game_phase = :start
    @state = {
        pot: 0,
        dealer: '',
        on_turn: '',
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
    index = @state[:players].length
    @player_index[competitor.name] = index
    @state[:players] << {
        id: index,
        name: competitor.name,
        stack: competitor.stack,
        bet: 0,
        status: ((competitor.stack > 0) ? 'active' : 'out'),
        hole_cards: []
    }
  end

  def hole_card(competitor, card)
    @state[:dealer] = @dealer % @state[:players].length
    @state[:on_turn] = @player_index[competitor.name]
    json_player(competitor)[:hole_cards] << format_card(card)
    save_step
  end


  def community_card(card)
    @state[:on_turn] = ''
    @state[:community_cards] << format_card(card)
    save_step
  end

  def bet(competitor, bet)
    @state[:on_turn] = @player_index[competitor.name]
    @state[:pot] = bet[:pot]
    json_player(competitor)[:stack] = competitor.stack
    json_player(competitor)[:bet] += bet[:amount]
    json_player(competitor)[:status] = "folded" if bet[:type] == :fold
    save_step
  end


  def showdown(competitor, hand)
  end

  def winner(competitor, amount)
    @game_phase = :end
    @state[:pot] -= amount
    json_player(competitor)[:stack] += amount
    save_step
  end

  def shutdown
    File.open(@file, 'w') do |file|
      file.puts "[" + @history.join(',') + "]"
    end
  end


  private

  def json_player(competitor)
    @state[:players][@player_index[competitor.name]]
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
end
