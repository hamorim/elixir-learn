defmodule ReportGenTest do
  use ExUnit.Case
  doctest ReportGen

  test "greets the world" do
    assert ReportGen.hello() == :world
  end
end
