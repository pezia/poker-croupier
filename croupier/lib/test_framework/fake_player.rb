
class Croupier::TestFramework::FakePlayer
  attr_reader :name
  attr_accessor :stack

  def initialize(name)
    @name = name
    Croupier::TestFramework::FakePlayerRegistry.instance.add(self)

    @messages = []
    @current_message = -1

    @stack = 1000
  end

  def competitor_status(player)
    @messages.push [:competitor_status, player]
  end

  def hole_card(card)
    @messages.push [:hole_card, card]
  end

  def bet(player, bet)
    @messages.push [:bet, player, bet]
  end

  def next_message
    @current_message += 1
    @messages[@current_message]
  end
end