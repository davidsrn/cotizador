# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cotizador,
  ecto_repos: [Cotizador.Repo]

# Configures the endpoint
config :cotizador, CotizadorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SBhhTqem1Hx76eWKnWoadxTv2RnOd/aC8zqFNX9+0RAKRfE8eT5fS5E0frvuT3vC",
  render_errors: [view: CotizadorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cotizador.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
