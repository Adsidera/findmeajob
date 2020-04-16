# Findmeajob

To start the project locally, install dependencies, create and migrate ecto database and seed it:

````
mix deps.get
mix ecto.create && mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server
