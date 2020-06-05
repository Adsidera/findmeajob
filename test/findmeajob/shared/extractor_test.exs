defmodule Findmeajob.Shared.ExtractorTest do
  use ExUnit.Case
  alias Findmeajob.Parsers.Shared.Extractor

  test "parses date for days and months but not for hours" do
    date = "7h ago"
    assert Extractor.parse_date(date) == date
  end

  test "does not parse if it is yesterday" do
    date = "yesterday"
    assert Extractor.parse_date(date) == date
  end

  test "does not parse date for minutes" do
    date = "30mins ago"
    assert Extractor.parse_date(date) == date
  end

  test "does not parse date with minus operator" do
    date = "< 1h ago"
    assert Extractor.parse_date(date) == date
  end
end