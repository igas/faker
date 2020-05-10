defmodule Faker.LocationTest do
  use ExUnit.Case, async: true

  doctest Faker.Location

  test "location/2" do
    {longitude, latitude} = Faker.Location.location(110_000, {0, 0})
    assert is_float(longitude)
    assert is_float(latitude)
    assert latitude < 1
    assert latitude > -1
    assert longitude < 1
    assert longitude > -1
  end
end
