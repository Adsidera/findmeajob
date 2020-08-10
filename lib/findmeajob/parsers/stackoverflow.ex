defmodule Findmeajob.Parsers.Stackoverflow do
  alias Findmeajob.Parsers.Shared.Extractor
  use Timex

  def parse(html) do
    html
    |> Floki.find(".listResults")
    |> Floki.find(".-job")
    |> Enum.map(&parse_job/1)
  end

  def parse_job(job) do
    %{
      title: job |> Floki.find("h2") |> Extractor.text("a[title]"),
      link: "https://www.stackoverflow.com#{job |> Floki.find("h2") |> Extractor.attribute("a", "href" )}",
      company: job |> Floki.find("h3") |> Extractor.text("span:first-child"),
      location: job |> Floki.find("h3") |> Extractor.text("span:last-child"),
      added_on: job |> Floki.find(".fs-caption") |> Extractor.text(".grid--cell:first-child") |> Extractor.parse_date()
    }
  end
end