defmodule Findmeajob.JobCrawler do
  alias Findmeajob.JobPost
  alias Findmeajob.Repo
  alias Findmeajob.Parsers.Stackoverflow
  alias Findmeajob.Parsers.RemoteJobs

  def call do
    {:ok, response} = Crawly.fetch("https://stackoverflow.com/jobs?id=173998&q=ruby")
    Stackoverflow.parse(response.body) |> create_job_posts()

    {:ok, response} = Crawly.fetch("https://remoteok.io/remote-ruby-jobs")
    RemoteJobs.parse(response.body) |> create_job_posts()
  end

  def create_job_posts(fetched_data) do
    fetched_data
      |> Enum.map(fn job ->
        JobPost.change_job_post(%JobPost{}, job) |> Repo.insert()
      end)
  end
end