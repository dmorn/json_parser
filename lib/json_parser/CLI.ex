defmodule JsonParser.CLI do
  @moduledoc ~S"""
  Command Line Interface module.

  Recognised arguments:
    - `--source path/to/file`
    - `--raw '{"foo : "bar""}'`
  """
  use Application
  require Logger
  import JsonParser

  @doc false
  def start(_type, _args), do: :ok

  @doc false
  def run({:parse, args}) when is_list(args) do
    args
    |> parse_args()
    |> process()
    |> puts
  end

  def run({:validate, args}) when is_list(args) do
    ret_val =
      args
      |> parse_args()
      |> process
    case ret_val do
      {:ok, _} -> Logger.info "Valid!"
      error -> puts(error)
    end
  end

  @doc false
  defp parse_args(args) do
    OptionParser.parse!(args,
      switches: [source: :string, raw: :string])
  end

  @doc """
  Reads and processes the given File.
  """
  def process({[source: path], _}) do
    Logger.info("Parsing json file @ #{path}..")
    path
    |> File.read!()
    |> parse()
  end

  @doc """
  Processes raw input data
  """
  def process({[raw: json], _}) do
    Logger.info("Parsing #{String.slice(json, 0..20)}..")
    parse(json)
  end

  @doc """
  Default case, when no arguments are passed. Reads and processes
  the given `source.json` file
  """
  def process({[], []}) do
    Logger.info("No arguments given.")
    Logger.info("Parsing default file @ source.json..")

    "source.json"
    |> File.read!()
    |> parse()
  end

  @doc """
  Fallback when unrecognised arguments are passed
  """
  def process({[], something}), do: Logger.error("What does #{something} mean ?")

  # Utils
  defp puts({:error, reason} = data), do: puts_e(reason, data)
  defp puts({:error, reason, _} = data), do: puts_e(reason, data)
  defp puts({:ok, json_map} = data) do
    IO.puts("\n#{inspect json_map}")
    data
  end
  defp puts(_), do: nil

  defp puts_e(message, data) do
    message
    |> inspect
    |> Logger.error
    data
  end
end
