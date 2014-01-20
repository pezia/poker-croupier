namespace rb API
namespace py API
namespace php API
namespace cpp API
namespace csharp API

namespace java com.devillsroom.poker.client

include "types.thrift"

service Spectator
{
    string name()

    void competitor_status(1:types.Competitor competitor)
    void bet(1:types.Competitor competitor, 2:types.Bet bet)
    void hole_card(1:types.Competitor competitor, 2:types.Card card)
    void community_card(1:types.Card card)
    void showdown(1:types.Competitor competitor, 2:list<types.Card> cards, 3:types.HandDescriptor hand)
    void winner(1:types.Competitor competitor, 2:i64 amount)

    oneway void shutdown()
}