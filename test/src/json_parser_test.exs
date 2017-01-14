defmodule Src.JsonParserTest do
  use ExUnit.Case

  describe "Basic Parser functionalities" do
    test "Parse an empty list" do
      tokens = [{:"[", 1}, {:"]", 1}]
      assert {:ok, []} = parse(tokens)
    end

    test "Parse an empty map" do
      tokens = [{:"{", 1}, {:"}", 1}]
      assert {:ok, %{}} = parse(tokens)
    end

    test "Parse nested empty list" do
      tokens = [{:"[", 1}, {:"[", 1}, {:"]", 1}, {:"]", 1}]
      assert {:ok, [[]]} = parse(tokens)
    end
  end

  test "Parse a list" do
    tokens = [{:"[", 1}, {:int, 1, 123}, {:",", 1}, {:float, 1, 3.21}, {:",", 1}, {:int, 1, 123}, {:"]", 1}]
    assert {:ok, [123, 3.21, 123]} = parse(tokens)
  end

  test "Parse a list with strings" do
    tokens = [{:"[", 1}, {:string, 1, 'ciao'}, {:",", 1}, {:string, 1, 'mare'}, {:"]", 1}]
    assert {:ok, ['ciao', 'mare']} = parse(tokens)
  end

  test "Parse a map with mixed keys and values types" do
    tokens = [{:"{", 1}, {:string, 1, 'ciao'}, {:":", 1}, {:int, 1, 123}, {:"}", 1}]
    assert {:ok, %{'ciao' => 123}} = parse(tokens)
  end

  test "Parse a large map with mixed keys and values types" do
    tokens = [{:"{", 1}, {:string, 1, 'ciao'},
 {:":", 1}, {:int, 1, 123}, {:",", 1},
 {:string, 1, 'hello'}, {:":", 1}, {:int, 1, 321},
 {:"}", 1}]

    assert {:ok, %{'ciao' => 123, 'hello' => 321}} = parse(tokens)
  end

  defp parse(tokens), do: :json_parser.parse(tokens)
end