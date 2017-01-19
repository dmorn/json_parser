defmodule Src.JsonLexerTest do
  use ExUnit.Case

  describe "Basic lexer functionalities" do

    test "Accepted input tokens" do
      input = '"ciao" 123 : { 3.14 ] true null'
      assert {:ok, tokens, _} = parse(input)
      assert ^tokens = [{:string, 1 , 'ciao'}, {:int, 1, 123}, {:":", 1}, {:"{", 1}, {:float, 1, 3.14}, {:"]", 1}, {true, 1}, {nil, 1}]
    end

    test "Failure with illegal char" do
      input = '{"ciao" => 123, "hello" : 321}'
      assert {:error, _, _} = parse(input)
    end

    test "Refute alphanumeric input" do
      input =  '12ff'
      assert {:error, _, _} = parse(input)
    end
  end

  defp parse(input), do: input |> to_charlist() |> :json_lexer.string()
end
