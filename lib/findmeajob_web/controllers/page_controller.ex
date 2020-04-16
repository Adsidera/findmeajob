defmodule FindmeajobWeb.PageController do
  use FindmeajobWeb, :controller

  alias Findmeajob.JobPosts

  def index(conn, _params) do
    job_posts = JobPosts.list_job_posts()
    render(conn, "index.html", job_posts: job_posts)
  end
end
