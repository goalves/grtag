defmodule GRTag.Repo do
  use Ecto.Repo,
    otp_app: :gr_tag,
    adapter: Ecto.Adapters.Postgres
end
