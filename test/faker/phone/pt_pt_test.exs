defmodule Faker.Phone.PtPtTest do
  use ExUnit.Case, async: true

  import Faker.Phone.PtPt

  @iterations 10_000

  test "landline_number/0 return starts with 2 or 3" do
    Stream.repeatedly(&landline_number/0)
    |> Enum.take(@iterations)
    |> Enum.each(fn generated_value ->
      assert String.match?(generated_value, ~r/^(2|3)[0-9]{8}$/)
    end)
  end

  test "cell_number/0 return starts with 91, 92, 93 or 96" do
    Stream.repeatedly(&cell_number/0)
    |> Enum.take(@iterations)
    |> Enum.each(fn generated_value ->
      assert String.match?(generated_value, ~r/^9(1|2|3|6)[0-9]{7}$/)
    end)
  end
end
