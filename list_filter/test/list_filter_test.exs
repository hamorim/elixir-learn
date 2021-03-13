defmodule ListFilterTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the odd counts" do
      assert ListFilter.call(["1", "3", "6", "43", "banana", "6"]) == 3
    end

    test "returns the odd counts for even list" do
      assert ListFilter.call(["2", "4", "6", "42", "banana", "6"]) == 0
    end
  end
end
