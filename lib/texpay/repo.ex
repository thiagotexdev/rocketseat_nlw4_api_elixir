defmodule Texpay.Repo do
  use Ecto.Repo,
    otp_app: :texpay,
    adapter: Ecto.Adapters.Postgres
end
