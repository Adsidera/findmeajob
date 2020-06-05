defmodule Findmeajob.JobCrawlerTest do
  use ExUnit.Case
  alias Findmeajob.JobCrawler

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Findmeajob.Repo)
  end

  test "parses jobs from stackoverflow" do
  end
end