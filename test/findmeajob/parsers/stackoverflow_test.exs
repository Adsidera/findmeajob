defmodule Findmeajob.Parsers.StackoverflowTest do
  use ExUnit.Case
  alias Findmeajob.Parsers.Stackoverflow

  test "parses response into maps with correct links" do
    response = Crawly.fetch("https://stackoverflow.com/jobs?q=ruby&r=true&sort=p")
    require IEx; IEx.pry()
    scraped_list = Stackoverflow.parse(response.body)
    job = List.first(scraped_list)
    {:ok, link} = Map.fetch(job, :link)
    {:ok, added_on} = Map.fetch(job, :added_on)

    assert Enum.count(scraped_list) != 0
    assert link =~"https://www.stackoverflow.com"
    assert added_on != "ago"
  end
end