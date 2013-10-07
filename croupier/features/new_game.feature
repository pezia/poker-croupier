Feature: new game of poker

  Scenario: Two players are registered, and they get notified about each other. After that they get their hole cards
    and the small blind player - Bob - folds. The first round is over and the winner is the big blind player, Adam.

    Given the croupier is ready for a game
    And "Adam" is a player
    And "Bob" is a player
    And the deck contains the following cards:
      | 5 | Diamonds |
      | 6 | Hearts   |
      | 7 | Spades   |
      | 8 | Clubs    |
    When I start a sit and go
    Then "Adam" gets the following list of players:
      | Adam |
      | Bob  |
    And "Bob" gets the following list of players:
      | Adam |
      | Bob  |
    And "Adam" gets the following hole cards:
      | 5 | Diamonds |
      | 7 | Spades   |
    And "Bob" gets the following hole cards:
      | 6 | Hearts   |
      | 8 | Clubs    |