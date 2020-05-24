defmodule Findmeajob.Parsers.StackoverflowTest do
  use ExUnit.Case
  alias Findmeajob.Parsers.Stackoverflow

  test "parses response into maps with correct links" do
    {:ok, response} = Crawly.fetch("https://stackoverflow.com/jobs?q=ruby&r=true&sort=p")
    scraped_list = Stackoverflow.parse(response.body)
    job = List.first(scraped_list)
    {:ok, link} = Map.fetch(job, :link)
    assert Enum.count(scraped_list) != 0
    assert link =~ "https://www.stackoverflow.com"
  end
end