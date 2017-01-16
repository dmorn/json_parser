defmodule Mix.Tasks.JsonParser.Parse do
  @moduledoc """
  Recognised arguments:
    - `--source path/to/file`
    - `--raw '{"foo : "bar"}'`
  """
  @shortdoc "Parses the given json (file/raw)"

  use Mix.Task
  alias JsonParser.CLI

  def run(args \\ []) do
    Mix.Task.run "app.start"
    CLI.run({:parse, args})
  end
end
