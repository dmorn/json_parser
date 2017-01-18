Nonterminals json list map elem.
Terminals '{' '}' '[' ']' ':' ',' string int float nil true false.
Rootsymbol json.

json -> '[' ']'                           : []. % Describing possible entry point
json -> '[' list ']'                      : '$2'.
json -> '{' '}'                           : #{}.
json -> '{' map '}'                       : '$2'.

list -> elem                              : ['$1'].
list -> elem ',' list                     : ['$1'|'$3'].

map -> elem ':' elem                      : #{'$1' => '$3'}.
map -> elem ':' elem ',' map              : maps:merge(#{'$1' => '$3'}, '$5').

elem -> string                            : extract_token('$1'). % Final expansion
elem -> int                               : extract_token('$1').
elem -> float                             : extract_token('$1').
elem -> true                              : extract_token('$1').
elem -> false                             : extract_token('$1').
elem -> nil                               : extract_token('$1').
elem -> json                              : '$1'.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value;
extract_token({_Line, Value}) -> Value.
