
class Croupier::TestFramework::FakePlayer
  attr_reader :name

  def initialize(name)
    @name = name
    Croupier::TestFramework::FakePlayerRegistry.instance.add(self)

    @messages = []
    @current_message = -1
  end

  def competitor_status(player)
    @messages.push [:competitor_status, player]
  end

  def hole_card(card)
    @messages.push [:hole_card, card]
  end

  def next_message
    @current_message += 1
    @messages[@current_message]
  end
end