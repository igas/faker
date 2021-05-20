defmodule Faker.Dwelling do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating Dwelling related data
  """

  @doc """
  Returns a dwelling type string

  ## Examples 
      iex> Faker.Dwelling.dwelling_type()
      "cycladic house"
      iex> Faker.Dwelling.dwelling_type()
      "shepard's hut"
      iex> Faker.Dwelling.dwelling_type()
      "cycladic house"
      iex> Faker.Dwelling.dwelling_type()
      "earth house"
  """

  @spec dwelling_type :: String.t()
  localize(:dwelling_type)

  @doc """
  Returns a room name string

  ## Examples
      iex> Faker.Dwelling.room()
      "kitchen"
      iex> Faker.Dwelling.room()
      "bathroom"
      iex> Faker.Dwelling.room()
      "dining room"
      iex> Faker.Dwelling.room()
      "living room"
  """
  @spec room :: String.t()
  localize(:room)
end
