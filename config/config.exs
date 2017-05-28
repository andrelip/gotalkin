# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :talkin,
  ecto_repos: [Talkin.Repo]

# Configures the endpoint
config :talkin, Talkin.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7M6EWrjNNbp9y1awss7G3M61oYhR0CZfTaxScVDOgILGZNEVsZcERlxkVWppR1Un",
  render_errors: [view: Talkin.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Talkin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Talkin",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "SkI1On3QZcnN8SeKX8kpPDFkGJ34Wlizky7jze9Ub+u+5ErKWvfyAcUJs0ThCK8S",
  serializer: Talkin.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
