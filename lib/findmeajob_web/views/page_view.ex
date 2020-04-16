defmodule FindmeajobWeb.PageView do
  use FindmeajobWeb, :view

  alias Findmeajob.JobPosts

  def location(job_post) do
    if job_post.location != nil do
      job_post.location
    else
      "Not available"
    end
  end
end
