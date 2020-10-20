defmodule Faker.AvatarTest do
  use ExUnit.Case, async: true

  import Faker.Avatar

  doctest Faker.Avatar

  test "image_url/0" do
    assert String.starts_with?(image_url(), "http://robohash.org/")
  end

    test "image_url/1" do
      assert String.starts_with?(image_url("myslug"), "http://robohash.org/")
      assert String.contains?(image_url("myslug"), "myslug")
    end

    test "image_url/2" do
      assert String.contains?(image_url(40, 60), "40x60")
    end

    test "image_url/3" do
      assert String.contains?(image_url("myslug", 70, 20), "70x20")
      assert String.contains?(image_url("myslug", 70, 20), "myslug")
    end


    test "image_url_with/0" do
      assert String.starts_with?(image_url_with_opts(), "http://robohash.org/")
      assert String.contains?(image_url_with_opts(), "/set_set")
      assert String.contains?(image_url_with_opts(), "/bgset_bg")
    end

    test "image_url_with_opts/1" do



      assert image_url_with_opts(ssl: true, set: 2, bg: 2, slug: "hello", height: 20, width: 10) == "https://robohash.org/set_set2/bgset_bg2/hello?size=10x20"
      assert image_url_with_opts(ssl: false, set: 2, bg: 2, slug: "hello", height: 20, width: 10) == "http://robohash.org/set_set2/bgset_bg2/hello?size=10x20"


      assert String.starts_with?(image_url_with_opts(ssl: true,  slug: "hello", height: 20, width: 10), "https://robohash.org/")
      assert String.contains?(image_url_with_opts(ssl: true,  slug: "hello", height: 20, width: 10), "hello?size=10x20")


      assert String.contains?(image_url_with_opts(ssl: true,  slug: "hello"), "hello")

    end

end
