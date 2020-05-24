defmodule Findmeajob.Parsers.RemoteJobs do
  alias Findmeajob.Parsers.Shared.Extractor
  def parse(html) do
    html
    |> Floki.find("tr.job")
    |> Enum.map(&parse_job/1)
  end

  def parse_job(job) do
    %{
      title: extract_text(job, "h2[itemprop=title]"),
      company: extract_text(job, "h3[itemprop=name]"),
      added_on: extract_text(job, "td.time > a"),
      link: "https://remoteok.io#{extract_attribute(job, "a[itemprop=url]", "href")}"
    }
  end

  def extract_text(job, selector) do
    Extractor.text(job, selector)
  end

  def extract_attribute(job, selector, attribute) do
    Extractor.attribute(job, selector, attribute)
  end
end