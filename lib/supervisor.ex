defmodule OAuth2.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(OAuth2.Manager, [])
    ]

    supervise(children, strategy: :one_for_one)
  end

end