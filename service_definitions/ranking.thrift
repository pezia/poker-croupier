namespace rb API
namespace py API
namespace php API
namespace cpp API
namespace csharp API

namespace java com.devillsroom.poker.client

include "types.thrift"

service Ranking
{
    types.HandDescriptor rank_hand(1:list<types.Card> cards)
}