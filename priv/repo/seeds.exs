# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Findmeajob.Repo.insert!(%Findmeajob.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Findmeajob.JobCrawler

JobCrawler.fetch_from_remote_jobs()
JobCrawler.fetch_from_railsjobs()
JobCrawler.fetch_from_stackoverflow()