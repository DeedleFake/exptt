defmodule ExPTT.Duration do
  def hour(), do: 60 * minute()
  def minute(), do: 60 * second()
  def second(), do: 1000

  def parse(duration, result \\ 0)
  def parse("", result), do: result

  def parse(duration, result) do
    case Integer.parse(duration) do
      {v, "ms" <> rest} -> parse(rest, result + v)
      {v, "s" <> rest} -> parse(rest, result + v * second())
      {v, "m" <> rest} -> parse(rest, result + v * minute())
      {v, "h" <> rest} -> parse(rest, result + v * hour())
    end
  end
end
