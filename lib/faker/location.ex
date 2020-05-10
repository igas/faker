defmodule Faker.Location do
  @moduledoc """
  Generating random locations in given area
  """
  @type location :: {float(), float()}

  @earth_radius 6_378_137
  @base_location {50.0, 0.0}

  @doc """
  Returns a random location inside a square of 2x distance of base location
  in distance from base location using the haversine formula
  https://en.wikipedia.org/wiki/Haversine_formula/

  ## Examples
  iex(1)> Faker.Location.location(111000)
  {49.31082153226589, -1.0237004535898575}
  iex(2)> Faker.Location.location(111000)
  {50.17003150421721, -1.2572991002344942}
  iex(3)> Faker.Location.location(111000)
  {49.837239966568546, 0.6050921891507782}
  iex(4)> Faker.Location.location(111000)
  {49.53208042114932, -1.493756117282846}
  """
  @spec location(integer(), location()) :: location()
  def location(distance, base_location \\ @base_location) do
    offset_in_metres(base_location, distance)
  end

  defp offset_in_metres({lat, lon}, distance) do
    rand_lat =
      Faker.random_uniform()
      |> shift_distance(distance)
      |> offset_in_rad_lat()
      |> rad_to_deg()
      |> Kernel.+(lat)

    rand_lon =
      Faker.random_uniform()
      |> shift_distance(distance)
      |> offset_in_rad_lon(lat)
      |> rad_to_deg()
      |> Kernel.+(lon)

    {rand_lat, rand_lon}
  end

  defp shift_distance(val, distance), do: distance * (val - 0.5) * 2

  defp offset_in_rad_lat(meters), do: meters / @earth_radius

  defp offset_in_rad_lon(meters, lat), do: meters / earth_slice_radius_on_lng(lat)

  defp earth_slice_radius_on_lng(lat),
    do: @earth_radius * :math.cos(:math.pi() * (lat / 180))

  defp rad_to_deg(rad), do: rad * (180 / :math.pi())
end
