defmodule Faker.Code.GitRef do
  @moduledoc ~S"""
  Functions that generate git refs

  ## Examples

      iex> Faker.Code.GitRef.commit()
      "f0e4c2f76c58916ec258f246851bea091d14d4247a2fc3e18694461b1816e13b"
      iex> Faker.Code.GitRef.branch()
      "feature/some-new-feature"
  """

  import Faker, only: [samplerp: 2]

  @doc """
  Generate random commit sha hash

  ## Examples
      iex> Faker.Code.GitRef.commit()
      "f0e4c2f76c58916ec258f246851bea091d14d4247a2fc3e18694461b1816e13b"
      iex> Faker.Code.GitRef.commit()
      "dd30729027d07e04455408fcac66fa612b34838b74c726076ffeb10e1058cc01"
  """
  @spec commit() :: binary()
  def commit do
    :sha256
    |> :crypto.hash(:crypto.strong_rand_bytes(32))
    |> Base.encode16()
  end

  @doc """
  Generate random branch name

  ## Examples
      iex> Faker.Code.GitRef.branch()
      "master"
      iex> Faker.Code.GitRef.branch()
      "bugfix/fix-broken-tests"
  """
  def branch do
    case branch_base() do
      {:unique, name} -> name
      {:prefix, prefix} -> "#{prefix}/#{random_branch_description()}"
    end
  end

  samplerp(:branch_base,
    unique: "master",
    unique: "develop",
    prefix: "feature",
    prefix: "bugfix",
    prefix: "hotfix"
  )

  defp random_branch_description do
    "#{branch_verb()}-#{branch_adj()}-#{branch_noun()}"
  end

  samplerp(:branch_verb, [
    "fix",
    "create",
    "add",
    "delete",
    "improve"
  ])

  samplerp(:branch_adj, [
    "broken",
    "unreceived",
    "new",
    "old",
    "legacy",
    "third-party"
  ])

  samplerp(:branch_noun, [
    "tests",
    "service",
    "class",
    "email",
    "database-schema"
  ])
end
