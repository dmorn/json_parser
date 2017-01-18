defmodule JsonParser do
  @moduledoc """
  Core module.
  """

  @doc ~S"""
  Receives a raw json string as input and returns `{:ok, result}` id the parsing
  is successfull. Returns `{:error, reason}` otherwise.

  ## Examples
    iex(1)> JsonParser.parse('{"foo" : ["bar", 123]}')
    {:ok, %{'foo' => ['bar', 123]}}

    iex(2)> JsonParser.parse('{"foo"}')
    {:error, {1, :json_parser, ['syntax error before: ', '\'}\'']}}

    iex(3)> JsonParser.parse('{"foo" : bar}')
    {:error, {1, :json_lexer, {:illegal, 'b'}}, 1}
  """
  def parse(str) do
    input = str |> to_char_list()
    with {:ok, tokens, _} <- :json_lexer.string(input),
         {:ok, result}    <- :json_parser.parse(tokens)
    do
      {:ok, result}
    end
  end
end
