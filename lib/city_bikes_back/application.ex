defmodule CityBikesBack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CityBikesBackWeb.Telemetry,
      # Start the Ecto repository
      CityBikesBack.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CityBikesBack.PubSub},
      # Start Finch
      {Finch, name: CityBikesBack.Finch},
      # Start the Endpoint (http/https)
      CityBikesBackWeb.Endpoint
      # Start a worker by calling: CityBikesBack.Worker.start_link(arg)
      # {CityBikesBack.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CityBikesBack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CityBikesBackWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
