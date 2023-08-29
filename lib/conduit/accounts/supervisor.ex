defmodule Conduit.Accounts.Supervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    children = [
      Conduit.Accounts.Projectors.User
    ]

    opts = [strategy: :one_for_one]

    Supervisor.init(children, opts)
  end
end
