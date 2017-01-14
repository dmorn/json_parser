# JsonParser

Notes

should I use `(["'])(?:(?=(\\?))\2.)*?\1` to match any character inside the quotes and avoid
the double quotes as a token?


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `json_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:json_parser, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/json_parser](https://hexdocs.pm/json_parser).

