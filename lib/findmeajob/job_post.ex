defmodule Findmeajob.JobPost do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_posts" do
    field :title
    field :company
    field :link
    field :location
    field :added_on
    timestamps()
  end

  def change_job_post(job_post, attrs ) do
    job_post
      |> cast(attrs, [:title, :company, :location, :link, :added_on])
  end
end