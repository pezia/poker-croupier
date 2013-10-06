Feature: new game of poker

  Scenario: Two players are registered, and they get notified about each other

    Given The croupier is ready for a game
    And "Adam" is a player
    And "Bob" is a player
    When I start a sit and go
    Then "Adam" gets the following list of players:
      | Adam |
      | Bob  |