# JsonParser

Notes

should I use `(["'])(?:(?=(\\?))\2.)*?\1` to match any character inside the quotes and avoid
the double quotes as a token?


## Installation

The package can be installed by adding `json_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:json_parser, github: "danielmorandini/json_parser"}]
end
```

You can specify the release by adding `tag: "x.x.x"`

