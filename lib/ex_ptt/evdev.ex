defmodule ExPTT.Evdev do
  defmodule Event do
    defstruct type: nil, code: nil, value: nil

    @bytes 24
    def bytes(), do: @bytes

    def parse(<<_time::16*8-binary, type::2*8, code::2*8, value::4*8-signed>>) do
      %__MODULE__{
        type: parse_type(type),
        code: parse_code(code),
        value: value
      }
    end

    defp parse_type(type), do: type
    defp parse_code(code), do: code
  end

  def stream(path) do
    import ExPTT.Evdev.Event

    Stream.resource(
      fn -> File.open!(path, [:raw]) end,
      fn file ->
        {:ok, data} = :file.read(file, bytes())
        {[parse(data)], file}
      end,
      &File.close/1
    )
  end
end
