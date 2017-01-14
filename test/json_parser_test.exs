defmodule JsonParserTest do
  use ExUnit.Case
  doctest JsonParser

  test "Parse json with nested structures" do
    json = '{"menu": {
  "id": "file",
  "value": "File",
  "popup": {
    "menuitem": [
      {"value": "New", "onclick": "CreateNewDoc"},
      {"value": "Open", "onclick": "Open!Doc()"},
      {"value": "Close", "onclick": "Close\\"doc"}
    ]
  }
}}'

    assert {:ok, _parsed} = JsonParser.parse(json)
  end

  test "Syntax error" do
    json = '{"foo" : {
      "bar"
    }}'

    assert {:error, {_line, :json_parser, _errors}} = JsonParser.parse(json)
  end

  test "Lexical error" do
    json = '{"foo" - "bar"}'

    assert {:error, {_line, :json_lexer, _errors}, _} = JsonParser.parse(json)
  end
end