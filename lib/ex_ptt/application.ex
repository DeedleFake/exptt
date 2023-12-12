defmodule ExPTT.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExPTT.XDo,
      {Task.Supervisor, name: ExPTT.DeviceSupervisor}
    ]

    opts = [strategy: :one_for_one, name: ExPTT.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
