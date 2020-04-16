defmodule Findmeajob.JobPosts do
  alias Findmeajob.Repo
  alias Findmeajob.JobPost
  def list_job_posts() do
    Repo.all(JobPost)
  end

  def find(id) do
    Repo.get(JobPost, id)
  end
end