Definitions.

WHITESPACE  = [\s\t\r\n]
FLOAT       = (\+|-)?[0-9]+\.[0-9]+
INT         = [0-9.]+
STRING      = "(\\.|[^\"])*"
NULL        = null|nil

Rules.

\{              : {token, {'{', TokenLine}}.
\}              : {token, {'}', TokenLine}}.
\[              : {token, {'[', TokenLine}}.
\]              : {token, {']', TokenLine}}.
:               : {token, {':', TokenLine}}.
,               : {token, {',', TokenLine}}.
true            : {token, {true, TokenLine}}.
false           : {token, {false, TokenLine}}.
{NULL}          : {token, {nil, TokenLine}}.
{FLOAT}         : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{INT}           : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{STRING}        : {token, {string, TokenLine, extract_string(TokenChars)}}. % Will match every char inside double quotes. Allows escaping chars
{WHITESPACE}+   : skip_token.

Erlang code.

extract_string(Str) ->
  string:sub_string(Str, 2, string:len(Str) - 1).
