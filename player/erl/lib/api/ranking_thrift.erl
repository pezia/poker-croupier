%%
%% Autogenerated by Thrift Compiler (0.9.1)
%%
%% DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
%%

-module(ranking_thrift).
-behaviour(thrift_service).


-include("ranking_thrift.hrl").

-export([struct_info/1, function_info/2]).

struct_info('i am a dummy struct') -> undefined.
%%% interface
% rank_hand(This, Cards)
function_info('rank_hand', params_type) ->
  {struct, [{1, {list, {struct, {'types_types', 'card'}}}}]}
;
function_info('rank_hand', reply_type) ->
  {struct, {'types_types', 'handDescriptor'}};
function_info('rank_hand', exceptions) ->
  {struct, []}
;
function_info(_Func, _Info) -> no_function.

