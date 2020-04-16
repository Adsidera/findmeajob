defmodule Findmeajob.Repo.Migrations.JobPost do
  use Ecto.Migration

  def change do
    create table(:job_posts) do
      add :title, :string
      add :company, :string
      add :link, :string
      add :location, :string
      add :added_on, :string
      timestamps()
    end
  end
end
