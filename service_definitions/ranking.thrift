namespace rb API
include "types.thrift"

struct HandDescriptor
{
    1:string name
    2:list<i16> ranks
}

service Ranking
{
    HandDescriptor rank_hand(1:list<types.Card> cards)
}