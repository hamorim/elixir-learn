defmodule ListFilter do
  def call(list) do
    list =
      list
      |> Enum.map(fn x -> Integer.parse(x) end)
      |> Enum.map(fn x -> get_number(x) end)
      |> Enum.filter(fn x -> x != :error end)
      |> Enum.filter(fn x -> rem(x, 2) == 1 end)

    Enum.count(list)
  end

  defp get_number({intVal, ""}), do: intVal
  defp get_number(:error), do: :error
end
