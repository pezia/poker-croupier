namespace rb API

struct Competitor
{
    1:string name
    2:i64 stack
}

enum Suit
{
    Hearts = 0
    Diamonds = 1
    Spades = 2
    Clubs = 3
}

enum BetType
{
    Fold = 0
    Check = 1
    Call = 2
    Blind = 3
    Raise = 4
}

struct Card
{
    1:i16 value
    2:Suit suit
    3:string name
}

struct Bet
{
    1:i64 amount
    2:BetType type
}

service PlayerStrategy
{
    string name()

    void competitor_status(1:Competitor competitor)
    void bet(1:Competitor competitor, 2:Bet bet)
    void hole_card(1:Card card)
    void community_card(1:Card card)
}