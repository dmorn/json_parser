defmodule Mix.Tasks.JsonParser.Validate do
  @moduledoc """
  Recognised arguments:
    - `--source path/to/file`
    - `--raw '{"foo : "bar""}'`
  """

  @shortdoc "Validates the given json (file/raw)"

  use Mix.Task
  alias JsonParser.CLI

  def run(args \\ []) do
    Mix.Task.run "app.start"
    CLI.run({:validate, args})
  end
end