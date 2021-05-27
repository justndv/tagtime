defmodule Tagtime.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/justndv/tagtime"

  def project do
    [
      app: :tagtime,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "Tagtime",
      source_url: @url
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:stream_data, "~> 0.5", only: [:dev, :test]},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    "Implementation of the TagTime universal ping schedule."
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE),
      licenses: ["MIT"],
      links: %{"GitHub" => @url}
    ]
  end
end
