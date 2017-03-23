# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :webgeeks_raffle,
  ecto_repos: [WebgeeksRaffle.Repo]

# Configures the endpoint
config :webgeeks_raffle, WebgeeksRaffle.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uSEn9GTEionP8xxwM6rJH8AAw5ZRCy/dTltJZEv4YWhQLdR/txYHzTmxQ1Lss1gK",
  render_errors: [view: WebgeeksRaffle.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebgeeksRaffle.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: WebgeeksRaffle.User,
  repo: WebgeeksRaffle.Repo,
  module: WebgeeksRaffle,
  logged_out_url: "/",
  opts: [:authenticatable]
# %% End Coherence Configuration %%

config :extwitter, :oauth, [
  consumer_key: "",
  consumer_secret: "",
  access_token: "",
  access_token_secret: ""
]
