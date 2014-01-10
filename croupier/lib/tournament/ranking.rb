class Croupier::Tournament::Ranking
  def initialize(state)
    @state = state
    @ranking = []
  end

  def get
    @ranking
  end

  def eliminate
    @state.players_eliminated.each do |player|
      unless @ranking.include?(player)
        @ranking << player
      end
    end
  end
end