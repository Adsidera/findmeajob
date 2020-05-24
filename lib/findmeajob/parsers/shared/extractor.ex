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
end