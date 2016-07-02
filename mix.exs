defmodule EasyBreadcrumbs.Mixfile do
  use Mix.Project

  def project do
    [
      app: :easy_breadcrumbs,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      package: package
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{ :inflex, "~> 1.7.0" }]
  end

  defp package do
  [
    files: ["lib", "mix.exs", "README", "LICENSE*"],
    maintainers: ["Eliathah Boda"],
    licenses: ["MIT License"],
    links: %{"GitHub" => "https://github.com/nerboda/phoenix_easy_breadcrumbs"}
  ]
end
end
