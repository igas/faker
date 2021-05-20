defmodule Faker.Dwelling.En do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating Dwelling related data in English
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
  @spec dwelling_type() :: String.t()
  sampler(:dwelling_type, [
    "bungalow",
    "cabin",
    "casa particular",
    "chalet",
    "cottage",
    "cycladic house",
    "dammuso",
    "dome house",
    "earth house",
    "house",
    "houseboat",
    "hut",
    "lighthouse",
    "pension",
    "shepard's hut",
    "tiny house",
    "townhouse",
    "trulio",
    "villa"
  ])

  @doc """
  Returns a room name string

  ## Examples
      iex> Faker.Dwelling.En.room()
      "kitchen"
      iex> Faker.Dwelling.En.room()
      "bathroom"
      iex> Faker.Dwelling.En.room()
      "dining room"
      iex> Faker.Dwelling.En.room()
      "living room"
  """
  @spec room :: String.t()
  sampler(:room, [
    "kitchen",
    "bathroom",
    "bedroom",
    "master bedroom",
    "living room",
    "dining room",
    "entry way",
    "garage",
    "laundry room",
    "basement"
  ])
end
