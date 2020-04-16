defmodule Findmeajob.JobCrawler do
  alias Findmeajob.JobPost
  alias Findmeajob.Repo

  def fetch_from_remote_jobs do
    {:ok, response} = Crawly.fetch("https://remoteok.io/remote-ruby-jobs")

    companies = response.body |> Floki.find("h3[itemprop=name]") |> purge_tuples_from_list()

    job_titles = response.body |> Floki.find("h2[itemprop=title") |> purge_tuples_from_list()

    links = response.body |> Floki.find("a[itemprop=url]") |> Floki.attribute("href")

    added_on = response.body |> Floki.find(".time > a") |> purge_tuples_from_list()

    List.zip([job_titles, companies, links, added_on])
      |>  Enum.map( fn item ->
            Tuple.to_list(item)
          end)
      |>  Enum.map(&%{title: Enum.at(&1, 0), company: Enum.at(&1, 1), link: "https://remoteok.io#{Enum.at(&1, 2)}", added_on: Enum.at(&1, 3), location: "Remote"})
      |> create_job_posts()
  end

  def fetch_from_railsjobs do
    {:ok, response} = Crawly.fetch("https://railsjobs.de/rubyonrails")

    locations = response.body |> Floki.find(".location") |> purge_tuples_from_list()

    companies = response.body |> Floki.find(".job_company") |> purge_tuples_from_list()

    job_titles = response.body |> Floki.find(".job > .internal_link") |> purge_tuples_from_list()

    links = response.body |> Floki.find(".job > .internal_link") |> Floki.attribute("href")

    added_on = response.body |> Floki.find(".created") |> purge_tuples_from_list()

    List.zip([job_titles, companies, locations, links, added_on])
    |>  Enum.map( fn item ->
      Tuple.to_list(item)
    end)
    |>  Enum.map(&%{title: Enum.at(&1, 0), company: Enum.at(&1, 1), location: Enum.at(&1, 2), link: "https://railsjobs.de/rubyonrails#{Enum.at(&1, 3)}", added_on: Enum.at(&1, 4)})
    |> create_job_posts()
  end

  def fetch_from_stackoverflow do
    {:ok, response} = Crawly.fetch("https://stackoverflow.com/jobs?q=ruby&r=true")

    job_titles = response.body |> Floki.find("h2 > a") |> Floki.attribute("title")

    links = response.body |> Floki.find("h2 > a") |> Floki.attribute("href")

    companies = response.body
                  |> Floki.find("h3 > span:first-child")
                  |> Floki.filter_out("span .s-tag")
                  |> Enum.map(&(Tuple.to_list(&1)))
                  |> Enum.map(&(Enum.at(&1, 2)))
                  |> Enum.map(&(Enum.at(&1, 0) |> String.trim_trailing()))

    locations = response.body
                  |> Floki.find("h3 > span:last-child")
                  |> Enum.map(&(Tuple.to_list(&1)))
                  |> Enum.map(&(Enum.at(&1, 2)))
                  |> List.flatten()
                  |> Enum.map(&(String.trim_trailing(&1) |> String.trim_leading()))

    added_on = response.body
                  |> Floki.find(".fs-caption > .grid--cell:first-child") |> purge_tuples_from_list()

    List.zip([job_titles, companies, locations, links, added_on])
      |>  Enum.map( fn item ->
        Tuple.to_list(item)
      end)
      |>  Enum.map(&%{title: Enum.at(&1, 0), company: Enum.at(&1, 1), location: Enum.at(&1, 2), link: "https://stackoverflow.com#{Enum.at(&1, 3)}", added_on: Enum.at(&1, 4) })
      |> create_job_posts()
  end

  def create_job_posts(fetched_data) do
    fetched_data
      |> Enum.map(fn job ->
        JobPost.change_job_post(%JobPost{}, job) |> Repo.insert()
      end)
  end

  def purge_tuples_from_list(results) do
    Enum.map(results, &(Tuple.delete_at(&1, 0)))
      |> Enum.map( &(Tuple.delete_at(&1, 0)))
      |> Enum.map( &(Tuple.to_list(&1)) )
      |> List.flatten()
  end
end