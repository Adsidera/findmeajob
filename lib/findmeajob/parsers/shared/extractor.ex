defmodule Findmeajob.Parsers.Shared.Extractor do
  def text(html, selector) do
    html
    |> Floki.find(selector)
    |> Floki.text
    |> String.trim()
  end

  def attribute(html, selector, attribute_name) do
    [attribute] =
      html
      |> Floki.find(selector)
      |> Floki.attribute(attribute_name)
    attribute
  end

  def parse_date(date) do
    if String.contains?(date, "<") || String.contains?(date, "yesterday") do
      date
    else
      {day, time} = Float.parse(date)
      cond do
        time =~ "d" ->
          Timex.shift(Date.utc_today, days: -(round(day))) |> Timex.format!( "%d %b %Y", :strftime)
        time =~ "mo" ->
          Timex.shift(Date.utc_today, months: -(round(day))) |> Timex.format!( "%d %b %Y", :strftime)
        true ->
          date
      end
    end
  end
end