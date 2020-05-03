defmodule Faker.Location do
  @moduledoc """
  Generating random locations in given area
  """

  @doc """
  Returns a random location

  ## Examples
    iex(1)> Location.location(1000)
    {49.86283137803154, 0.03094694958861186}
    iex(2)> Location.location(1000)
    {50.00726797585422, 0.07576344274959462}
    iex(3)> Location.location(1000)
    {49.953972550067206, 0.03563844042581768}
    iex(4)> Location.location(1000)
    {49.94782059338023, -0.20998609857383446}
  """
  def location(radius, base_location \\ {50.0, 0.0}) do
    offset_in_metres(base_location, radius)
  end

  @earth_radius 6378137
  def offset_in_metres({lat, lon}, radius) do
    rand_lat =
      Faker.random_uniform()
      |> shift_radious(radius)
      |> offset_in_rad_lat()
      |> to_decimal_degrees()
      |> Kernel.+(lat)
    rand_lon = 
      Faker.random_uniform()
      |> shift_radious(radius)
      |> offset_in_rad_lon(lat)
      |> to_decimal_degrees()
      |> Kernel.+(lon)

    {rand_lat, rand_lon}
  end

  defp shift_radious(val, radius), do: radius * (val - 0.5) * 2
  defp offset_in_rad_lat(meters), do: meters / @earth_radius
  defp offset_in_rad_lon(meters, lat), do: meters / earth_slice_radious_on_lng(lat)

  defp earth_slice_radious_on_lng(lat),
    do: @earth_radius * :math.cos(:math.pi * (lat / 180) )

  defp to_decimal_degrees(rad), do: rad * (180 / :math.pi)
end
