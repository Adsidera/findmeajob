defmodule Findmeajob.Repo do
  use Ecto.Repo,
    otp_app: :findmeajob,
    adapter: Ecto.Adapters.Postgres
end
