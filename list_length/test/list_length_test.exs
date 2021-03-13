defmodule ListLengthTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the list length" do
      assert ListLength.call([1, 2, 3]) == 3
    end

    test "returns the empty list length" do
      assert ListLength.call([]) == 0
    end
  end
end
