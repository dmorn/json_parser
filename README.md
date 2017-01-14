# JsonParser

## Inspiration
I read Andrea Leopardi's great [article](http://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/) about tokenizing and parsing string and its actual utility in the real world.

After that, I decided to build a library that parses json formatted strings using this approach.

## Description
The Project allows to parse jsons through a the `mix` tasks provided or directly using the `JsonParser` module.
Read the docs for further information.

## Installation
The package can be installed by adding `json_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:json_parser, github: "danielmorandini/json_parser"}]
end
```

You can specify the release by adding `tag: "x.x.x"`
