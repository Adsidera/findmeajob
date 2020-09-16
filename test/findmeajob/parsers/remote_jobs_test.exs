defmodule Findmeajob.Parsers.RemoteJobsTest do
  use ExUnit.Case
  alias Findmeajob.Parsers.RemoteJobs

  test "parses response into" do
    response = Crawly.fetch("https://remoteok.io/remote-ruby-jobs")
    scraped_list = RemoteJobs.parse(response.body)
    job = List.first(scraped_list)
    {:ok, link} = Map.fetch(job, :link)

    assert Enum.count(scraped_list) != 0
    assert link =~ "https://remoteok.io"
    refute Enum.find(scraped_list, fn job -> job[:added_on] == '1yr' end)
  end
end