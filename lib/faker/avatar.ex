defmodule Faker.Avatar do
  alias Faker.Lorem

  @moduledoc """
  Functions for generate random urls for avatars.
  """

  @doc """
  Return avatar url with random set and background.

  ## Examples

      iex> Faker.Avatar.image_url()
      "http://robohash.org/set_set1/bgset_bg2/kQqaIfGqxsjFoNIT"
      iex> Faker.Avatar.image_url()
      "http://robohash.org/set_set2/bgset_bg2/6"
      iex> Faker.Avatar.image_url()
      "http://robohash.org/set_set2/bgset_bg2/J"
      iex> Faker.Avatar.image_url()
      "http://robohash.org/set_set3/bgset_bg1/JNth88PrhGDhwp4LNQMt"
  """
  @spec image_url() :: String.t()
  def image_url do
    image_url_with_opts()
  end

  @doc """
  Return avatar url for given `slug`.

  ## Examples

      iex> Faker.Avatar.image_url('faker')
      "http://robohash.org/faker"
      iex> Faker.Avatar.image_url('elixir')
      "http://robohash.org/elixir"
      iex> Faker.Avatar.image_url('plug')
      "http://robohash.org/plug"
      iex> Faker.Avatar.image_url('ecto')
      "http://robohash.org/ecto"
  """
  @spec image_url(binary) :: String.t()
  def image_url(slug) do
    image_url_with_opts(slug: slug, ssl: false, raw: true)
  end

  @doc """
  Return avatar url with random set and background, with size `width` x `height`
  pixels.

  ## Examples

      iex> Faker.Avatar.image_url(200, 200)
      "http://robohash.org/set_set1/bgset_bg2/kQqaIfGqxsjFoNIT?size=200x200"
      iex> Faker.Avatar.image_url(800, 600)
      "http://robohash.org/set_set2/bgset_bg2/6?size=800x600"
      iex> Faker.Avatar.image_url(32, 32)
      "http://robohash.org/set_set2/bgset_bg2/J?size=32x32"
      iex> Faker.Avatar.image_url(128, 128)
      "http://robohash.org/set_set3/bgset_bg1/JNth88PrhGDhwp4LNQMt?size=128x128"
  """
  @spec image_url(integer, integer) :: String.t()
  def image_url(width, height)
      when is_integer(width) and is_integer(height) do
    image_url_with_opts(
      ssl: false,
      raw: false,
      set: nil,
      bg: nil,
      slug: nil,
      height: height,
      width: width
    )
  end

  @doc """
  Return avatar url for given `slug`, with size `width` x `height` pixels.

  ## Examples

      iex> Faker.Avatar.image_url('phoenix', 100, 100)
      "http://robohash.org/phoenix?size=100x100"
      iex> Faker.Avatar.image_url('haskell', 200, 200)
      "http://robohash.org/haskell?size=200x200"
      iex> Faker.Avatar.image_url('ocaml', 300, 300)
      "http://robohash.org/ocaml?size=300x300"
      iex> Faker.Avatar.image_url('idris', 400, 400)
      "http://robohash.org/idris?size=400x400"
  """
  @spec image_url(binary, integer, integer) :: String.t()
  def image_url(slug, width, height)
      when is_integer(width) and is_integer(height) do
    image_url_with_opts(
      ssl: false,
      raw: true,
      set: nil,
      bg: nil,
      slug: slug,
      height: height,
      width: width
    )
  end

  @doc """
    Return avatar url for given set of options. This gives you more control of how the
    url is generated.

  Options -
  * ssl - boolean - true - returns an https:// url
  * bg - integer - the background set to use for the image
  * set - integer - the image set to use for the image
  * slug - string - a string used to generate the hash
  * raw - boolean - true - does not generate a random set/bg for the image
  * height - integer - the height in pixels of the image
  * width - integer - the width in pixels of the image


  """
  @spec image_url_with_opts(
          ssl: boolean(),
          set: integer(),
          bg: integer(),
          raw: boolean(),
          slug: String.t(),
          height: integer(),
          width: integer
        ) :: String.t()
  def image_url_with_opts(
        opts \\ [
          ssl: false,
          set: nil,
          bg: nil,
          raw: false,
          slug: nil,
          height: nil,
          width: nil
        ]
      ) do
    opt_map =
      Enum.into(opts, %{
        ssl: false,
        set: nil,
        bg: nil,
        raw: false,
        slug: nil,
        height: nil,
        width: nil
      })

    "#{robohash_url(opt_map[:ssl])}#{set_url(opt_map)}#{bg_url(opt_map)}/#{slug(opt_map)}#{
      query(opt_map)
    }"
  end

  defp slug(%{slug: nil}), do: random_slug()
  defp slug(%{slug: value}), do: value
  defp slug(_), do: random_slug()

  defp query(%{height: height, width: width}) when is_integer(height) and is_integer(width) do
    "?size=#{width}x#{height}"
  end

  defp query(_), do: ""

  defp random_slug(), do: "#{Lorem.characters(1..20)}"
  defp set_url(%{raw: true}), do: ""
  defp set_url(%{raw: false, set: nil}), do: set()
  defp set_url(%{raw: false, set: set_value}), do: set_to_url(set_value)
  defp bg_url(%{raw: true}), do: ""
  defp bg_url(%{raw: false, bg: nil}), do: bg()
  defp bg_url(%{raw: false, bg: bg_value}), do: bg_to_url(bg_value)

  defp robohash_url(true) do
    "https://robohash.org"
  end

  defp robohash_url(_) do
    "http://robohash.org"
  end

  defp bg_to_url(number) do
    case number do
      2 -> "/bgset_bg2"
      _ -> "/bgset_bg1"
    end
  end

  defp set_to_url(number) do
    case number do
      2 -> "/set_set2"
      3 -> "/set_set3"
      _ -> "/set_set1"
    end
  end

  defp bg do
    bg_to_url(Faker.random_between(1, 2))
  end

  defp set do
    set_to_url(Faker.random_between(1, 3))
  end
end
