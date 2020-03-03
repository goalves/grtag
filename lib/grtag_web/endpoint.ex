defmodule GRTagWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :gr_tag

  plug Plug.Static,
    at: "/",
    from: :gr_tag,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_grtag_key",
    signing_salt: "09vy0Btz"

  plug GRTagWeb.Router
end
