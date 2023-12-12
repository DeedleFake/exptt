defmodule ExPTT.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    {[config: config], [], []} = OptionParser.parse(System.argv(), strict: [config: :string])

    children = [
      ExPTT.XDo,
      {Task.Supervisor, name: ExPTT.DeviceSupervisor},
      {Task, fn -> ExPTT.start_devices(config) end}
    ]

    opts = [strategy: :one_for_one, name: ExPTT.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
