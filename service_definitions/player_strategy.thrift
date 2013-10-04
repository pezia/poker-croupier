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

struct Card
{
    1:i16 value
    2:Suit suit
}

service PlayerStrategy
{
    string name()

    void competitor_status(1:Competitor competitor)
    void hole_card(1:Card card)
    void community_card(1:Card card)
}