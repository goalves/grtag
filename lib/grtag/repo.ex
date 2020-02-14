defmodule GRTag.Repo do
  use Ecto.Repo,
    otp_app: :GRTag,
    adapter: Ecto.Adapters.Postgres
end
