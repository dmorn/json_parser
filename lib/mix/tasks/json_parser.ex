defmodule Mix.Tasks.JsonParser do

  @shortdoc "Decode raw json data"
  @moduledoc @shortdoc

  use Mix.Task
  require Logger
  import JsonParser

  def run(args \\ []) do
    Mix.Task.run "app.start"

    args
    |> parse_args()
    |> process
    |> puts
  end

  defp parse_args(args) do
    OptionParser.parse!(args,
      switches: [source: :string, raw: :string, validate: :boolean])
  end

  defp process({[help: true], _}) do
    IO.puts "\nUsage: $ mix json_parser [options]"
    IO.puts "Commands:"

    IO.puts "\n--validate\t\tPerforms a validation without printing the result"
    IO.puts "--raw 'json'\t\tTakes json as source"
    IO.puts "--source 'path'\t\tUses path as source file"
    IO.puts "\nDefaults using 'source.json' as source file"
  end

  defp process({opts, []}) do
    # Parse options
    validate = Keyword.get(opts, :validate, false)
    file = Keyword.get(opts, :source, "source.json")
    raw = Keyword.get(opts, :raw, "")
    do_process(validate, file, raw)
  end

  defp process({[], something}), do: Logger.error("What does #{something} mean ?")


  # Default case, when no arguments are passed. Reads and processes
  # the given `source.json` file
  defp do_process(validate, "source.json" = file, "") do
    Logger.info("No file or raw data specified.")
    Logger.info("Parsing default file @ source.json..")

    result =
      file
      |> File.read!()
      |> parse()
    {validate, result}
  end

  # Second case: The user provided some raw data
  defp do_process(validate, "source.json", json) do
    Logger.info("Parsing #{String.slice(json, 0..20)}..")
    {validate, parse(json)}
  end

  # Third case: The user provided an input file path
  defp do_process(validate, file, "") do
    Logger.info("Parsing json file @ #{file}..")

    result =
      file
      |> File.read!()
      |> parse()
    {validate, result}
  end

  # Utils
  defp puts({_, {:error, reason}}), do: puts_e(reason)
  defp puts({_, {:error, reason, _}}), do: puts_e(reason)
  defp puts({true, {:ok, _}}), do: Logger.info("Valid !")
  defp puts({_, {:ok, json_map}}), do: IO.puts("\n#{inspect json_map}")
  defp puts(_), do: nil

  defp puts_e(message) do
    message
    |> inspect
    |> Logger.error
  end
end