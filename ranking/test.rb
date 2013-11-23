$:.push('lib/api')

require 'thrift'
require 'ranking'

transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9080))
protocol = Thrift::BinaryProtocol.new(transport)
client = API::Ranking::Client.new(protocol)

transport.open()

class TestClient

  def initialize(client)
    @client = client
  end

  def by_name(name)
    API::Card.new.tap { |card| card.name = name }
  end

  def rank_by_names(hand)
    p @client.rank_hand hand.map { |name| by_name(name) }
  end
end


test_client = TestClient.new(client)

test_client.rank_by_names ['Ace of Spades', 'King of Clubs', '10 of Spades', '5 of Hearts', '2 of Diamonds']
test_client.rank_by_names ['Ace of Spades', 'Ace of Clubs', '10 of Spades', '5 of Hearts', '2 of Diamonds']
test_client.rank_by_names ['Ace of Spades', 'Ace of Clubs', '10 of Spades', '10 of Hearts', '2 of Diamonds']
test_client.rank_by_names ['Ace of Spades', 'Ace of Clubs', 'Ace of Diamonds', '10 of Hearts', '2 of Diamonds']
test_client.rank_by_names ['Ace of Spades', 'King of Clubs', 'Queen of Spades', 'Jack of Hearts', '10 of Diamonds']
test_client.rank_by_names ['Ace of Spades', 'King of Spades', '10 of Spades', '5 of Spades', '2 of Spades']
test_client.rank_by_names ['Ace of Spades', 'Ace of Clubs', 'Ace of Spades', '10 of Hearts', '10 of Diamonds']
test_client.rank_by_names ['Ace of Spades', 'Ace of Clubs', 'Ace of Diamonds', 'Ace of Hearts', '2 of Diamonds']
test_client.rank_by_names ['Ace of Spades', 'King of Spades', 'Queen of Spades', 'Jack of Spades', '10 of Spades']

four_of_hearts = API::Card.new.tap do |card|
  card.value = 4
  card.suit = API::Suit::Hearts
end

four_of_spades = API::Card.new.tap do |card|
  card.value = 4
  card.suit = API::Suit::Spades
end

ace_of_spades = API::Card.new.tap do |card|
  card.value = 14
  card.suit = API::Suit::Spades
end

p client.rank_hand [ four_of_hearts, four_of_spades, ace_of_spades ]