defmodule Findmeajob.JobCrawler do
  alias Findmeajob.JobPost
  alias Findmeajob.Repo
  alias Findmeajob.Parsers.Stackoverflow
  alias Findmeajob.Parsers.RemoteJobs

  @stackoverflow_url "https://stackoverflow.com/jobs?q=ruby&r=true"
  @remote_jobs_url "https://remoteok.io/remote-ruby-jobs"
  def parse_and_insert do
    parse_from_stackoverflow()   |> create_job_posts()
    parse_from_remote_jobs()     |> create_job_posts()
  end

  def parse_from_stackoverflow do
    response = Crawly.fetch(@stackoverflow_url)
    Stackoverflow.parse(response.body)
  end

  def parse_from_remote_jobs do
    response = Crawly.fetch(@remote_jobs_url)
    RemoteJobs.parse(response.body)
  end

  def create_job_posts(fetched_data) do
    fetched_data
      |> Enum.map(fn job ->
        JobPost.change_job_post(%JobPost{}, job) |> Repo.insert()
      end)
  end
end