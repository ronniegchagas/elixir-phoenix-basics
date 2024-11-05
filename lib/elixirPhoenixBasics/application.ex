defmodule ElixirPhoenixBasics.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirPhoenixBasicsWeb.Telemetry,
      ElixirPhoenixBasics.Repo,
      {DNSCluster, query: Application.get_env(:elixirPhoenixBasics, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirPhoenixBasics.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirPhoenixBasics.Finch},
      # Start a worker by calling: ElixirPhoenixBasics.Worker.start_link(arg)
      # {ElixirPhoenixBasics.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirPhoenixBasicsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirPhoenixBasics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirPhoenixBasicsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
