defmodule Kandesk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Kandesk.Repo,
      # Start the Telemetry supervisor
      KandeskWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kandesk.PubSub},
      # Start the endpoint when the application starts
      KandeskWeb.Endpoint
      # Starts a worker by calling: Kandesk.Worker.start_link(arg)
      # {Kandesk.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kandesk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KandeskWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
