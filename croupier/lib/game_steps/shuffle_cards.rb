class Croupier::GameSteps::ShuffleCards
  def run(game_state)
    game_state.deck.shuffle
  end
end