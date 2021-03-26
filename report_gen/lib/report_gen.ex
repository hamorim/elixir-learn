defmodule ReportGen do
  def call() do
    "report.csv"
    |> File.stream!()
    |> Stream.map(&parser_line/1)
    |> Enum.reduce(
      %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}},
      &sum_values/2
    )
  end

  defp sum_values(
         [name, hours, day, month, year],
         %{
           "all_hours" => all_hours,
           "hours_per_month" => hours_per_month,
           "hours_per_year" => hours_per_year
         } = report
       ) do
    all_hours = parse_hours(all_hours, name, hours)
    hours_per_month = parse_hours_by_month(hours_per_month, name, hours, year, month, day)
    hours_per_year = parse_hours_by_year(hours_per_year, name, hours, year)

    %{
      report
      | "all_hours" => all_hours,
        "hours_per_month" => hours_per_month,
        "hours_per_year" => hours_per_year
    }
  end

  defp parse_hours(all_hours, name, hours) do
    Map.put(all_hours, name, value(all_hours[name]) + hours)
  end

  defp parse_hours_by_year(hours_per_year, name, hours, year) do
    user_hours = value_map(hours_per_year[name])

    Map.put(
      hours_per_year,
      name,
      Map.put(user_hours, year, value(user_hours[year]) + hours)
    )
  end

  defp parse_hours_by_month(hours_per_month, name, hours, year, month, day) do
    {:ok, date} = Date.new(year, month, day)
    month_name = Calendar.strftime(date, "%B")

    user_hours = value_map(hours_per_month[name])

    Map.put(
      hours_per_month,
      name,
      Map.put(user_hours, month_name, value(user_hours[month_name]) + hours)
    )
  end

  defp parser_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> normalize()
  end

  defp normalize([name | values]) do
    [name] ++ Enum.map(values, &String.to_integer/1)
  end

  defp value(x) when is_nil(x), do: 0
  defp value(x), do: x
  defp value_map(x) when is_nil(x), do: %{}
  defp value_map(x), do: x
end
