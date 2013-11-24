namespace rb API
include "types.thrift"

service Ranking
{
    types.HandDescriptor rank_hand(1:list<types.Card> cards)
}