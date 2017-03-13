defmodule {{ ModuleName }}.Mixfile do
  use Mix.Project

  def project do
    [
      app:             :{{ AppName }},
      version:         "0.1.0-#{git_sha()}",
      elixir:          "~> 1.4",
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      elixirc_paths:   elixirc_paths(Mix.env),
      aliases:         aliases(),
      deps:            deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:distillery, "~> 1.1.0"}
    ]
  end

  defp aliases do
    [
      test:    ["ecto.drop", "ecto.create --quiet", "ecto.migrate --quiet", "test"],
      upgrade: "release --upgrade"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  defp git_sha() do
    {result, _exit_code} = System.cmd("git", ["rev-parse", "HEAD"])
    String.slice(result, 0, 5)
  end
end
