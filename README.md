# Findmeajob

`Findmeajob` is a basic webscraping application, showing updated remote and Berlin-based job vacancies for Ruby developers, as listed in `remote.io` and `stackoverflow.com`.

Scraping happens for the moment while seeding database, so, please, do not forget to `mix run priv/repo/seeds.exs`, while installing locally.

Please note, that the persisting of database through seeding will have to be replaced soon by a daily schedule of a job process for scanning and persisting of new job posts.

To start the project locally, install dependencies, create and migrate ecto database and seed it:

````
mix deps.get
mix ecto.create && mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server
