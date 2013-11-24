namespace rb API
include "types.thrift"

service Spectator
{
    string name()

    void competitor_status(1:types.Competitor competitor)
    void bet(1:types.Competitor competitor, 2:types.Bet bet)
    void hole_card(1:types.Competitor competitor, 2:types.Card card)
    void community_card(1:types.Card card)
    void showdown(1:list<types.Card> cards, 2:types.HandDescriptor hand)
    void winner(1:types.Competitor competitor, 2:i64 amount)
}