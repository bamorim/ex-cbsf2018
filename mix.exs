defmodule Coins.MixProject do
  use Mix.Project

  def project do
    [
      app: :coins,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Coins.Application, []},
      extra_applications: [:logger, :eventstore]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Domain
      {:commanded, github: "commanded/commanded", override: true},
      {:commanded_eventstore_adapter, "~> 0.3"},
      {:commanded_ecto_projections, "~> 0.6"},
      {:ecto, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:uuid, "~> 1.1"},
      {:eventstore, ">= 0.13.0"}
    ]
  end

  defp aliases do
    [
      setup_es: ["event_store.create", "event_store.init"],
      setup_ecto: ["ecto.create", "ecto.migrate"],
      setup_db: ["setup_es", "setup_ecto"],
      drop_db: ["ecto.drop", "event_store.drop"],
      reset_db: ["drop_db", "setup_db"],
      test: ["reset_db", "test --trace"]
    ]
  end
end
