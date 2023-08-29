# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :conduit,
  ecto_repos: [Conduit.Repo],
  event_stores: [Conduit.EventStore]

# Configures the endpoint
config :conduit, ConduitWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ConduitWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Conduit.PubSub,
  live_view: [signing_salt: "9hsoayd8"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :conduit, Conduit.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :conduit, Conduit.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Conduit.EventStore
  ],
  pubsub: :local,
  registry: :local

config :conduit, Conduit.EventStore,
  column_data_type: "jsonb",
  serializer: Commanded.Serialization.JsonSerializer

config :commanded_ecto_projections, repo: Conduit.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
