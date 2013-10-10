Feature: New game of poker

  Scenario: Two players are registered, and they get notified about each other. After that they post their blinds and
            get their hole cards.
    Given the croupier is ready for a game
    And "Adam" is a player
    And "Bob" is a player
    And the deck contains the following cards:
      | 5 of Diamonds |
      | 6 of Hearts   |
      | 7 of Spades   |
      | 8 of Clubs    |
    When I start a sit and go
    Then Players get the following list of players:
      | Adam |
      | Bob  |
    And "Adam" is reported to have posted the small blind
    And "Bob" is reported to have posted the big blind
    And "Adam" gets the following hole cards:
      | 5 of Diamonds |
      | 7 of Spades   |
    And "Bob" gets the following hole cards:
      | 6 of Hearts |
      | 8 of Clubs  |