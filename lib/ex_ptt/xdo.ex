defmodule ExPTT.XDo do
  use GenServer

  def start_link(opts \\ []) do
    opts = Keyword.validate!(opts, name: __MODULE__)
    GenServer.start_link(__MODULE__, [], opts)
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end
end
