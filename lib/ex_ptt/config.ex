defmodule ExPTT.Config do
  defstruct key: nil, sym: nil, retry: 10000, devices: []

  def parse(file) do
    for line <- file, reduce: %__MODULE__{} do
      config ->
        line |> String.split(~r/\s/, trim: true) |> strip_comment([]) |> parse_line(config)
    end
  end

  defp strip_comment([], result), do: Enum.reverse(result)
  defp strip_comment(["#" <> _ | rest], result), do: strip_comment([], result)
  defp strip_comment([first | rest], result), do: strip_comment(rest, [first | result])

  defp parse_line([], config), do: config
  defp parse_line(["key", num], config), do: %__MODULE__{config | key: String.to_integer(num)}
  defp parse_line(["sym", name], config), do: %__MODULE__{config | sym: name}

  defp parse_line(["retry", time], config),
    do: %__MODULE__{config | retry: ExPTT.Duration.parse(time)}

  defp parse_line(["device", dev], config),
    do: %__MODULE__{config | devices: [Path.wildcard(dev) | config.devices]}
end
