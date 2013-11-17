module Croupier::GameSteps

  autoload :Base, 'lib/game_steps/base'
  autoload :Betting, 'lib/game_steps/betting'
  autoload :BettingStep, 'lib/game_steps/betting_step'
  autoload :DealCommunityCard, 'lib/game_steps/deal_community_card'
  autoload :DealHoleCards, 'lib/game_steps/deal_hole_cards'
  autoload :DealFlop, 'lib/game_steps/deal_flop'
  autoload :IntroducePlayers, 'lib/game_steps/introduce_players'
  autoload :RequestBlinds, 'lib/game_steps/request_blinds'
  autoload :Showdown, 'lib/game_steps/showdown'
  autoload :ShuffleCards, 'lib/game_steps/shuffle_cards'

  DealTurnCard = DealCommunityCard
  DealRiverCard = DealCommunityCard
end