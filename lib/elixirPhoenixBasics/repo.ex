defmodule ElixirPhoenixBasics.Repo do
  use Ecto.Repo,
    otp_app: :elixirPhoenixBasics,
    adapter: Ecto.Adapters.Postgres
end
