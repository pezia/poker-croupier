-ifndef(_types_types_included).
-define(_types_types_included, yeah).

-define(types_Suit_Hearts, 0).
-define(types_Suit_Diamonds, 1).
-define(types_Suit_Spades, 2).
-define(types_Suit_Clubs, 3).

-define(types_BetType_Fold, 0).
-define(types_BetType_Check, 1).
-define(types_BetType_Call, 2).
-define(types_BetType_Blind, 3).
-define(types_BetType_Raise, 4).
-define(types_BetType_Allin, 5).

%% struct competitor

-record(competitor, {name :: string() | binary(),
                     stack :: integer()}).

%% struct card

-record(card, {value :: integer(),
               suit :: integer(),
               name :: string() | binary()}).

%% struct bet

-record(bet, {amount :: integer(),
              type :: integer(),
              new_pot_size :: integer()}).

%% struct betLimits

-record(betLimits, {to_call :: integer(),
                    minimum_raise :: integer()}).

%% struct handDescriptor

-record(handDescriptor, {name :: string() | binary(),
                         ranks :: list()}).

-endif.
