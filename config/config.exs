# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :texpay,
  ecto_repos: [Texpay.Repo]

# Configures the endpoint
config :texpay, TexpayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eRNyQHbY9XRb8hz0xXGaY0uu9pFxMK+zGDreeA3/wuogN5KBN/6qqjOThUEiACeq",
  render_errors: [view: TexpayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Texpay.PubSub,
  live_view: [signing_salt: "Mh0W0anN"]

config :texpay, Texpay.Repo,
migration_primary_key: [type: :binary_id],
migration_foreign_key: [type: :binary_id]

config :texpay, :basic_auth,
username: "texdev",
password: "123456"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
