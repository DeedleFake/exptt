defmodule ExPTT.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    {options, [], []} = OptionParser.parse(System.argv(), strict: [config: :string])
    config = Keyword.get(options, :config, "~/.config/exptt/config")

    children = [
      ExPTT.XDo,
      {Task.Supervisor, name: ExPTT.DeviceSupervisor},
      {Task, fn -> ExPTT.start_devices(config) end}
    ]

    opts = [strategy: :one_for_one, name: ExPTT.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
