defmodule Plug.Assign.Mixfile do
  use Mix.Project

  def project do
    [
      app: :plug_assign,
      name: "Plug.Assign",
      version: "2.0.0",
      elixir: "~> 1.15.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: [extras: ["README.md", "LICENSE.md"], main: "readme"],
      source_url: "https://github.com/nshafer/plug_assign",
      homepage_url: "http://blog.lotech.org/a-phoenix-plug-for-assigning-template-variables.html"
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:plug, "~> 1.5"},
      {:ex_doc, "~> 0.21.1", only: :dev}
    ]
  end

  defp description do
    """
    A simple plug to allow setting variables in a connection.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Nathan Shafer"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/nshafer/plug_assign",
        "Docs" => "http://hexdocs.pm/plug_assign",
        "Howto" => "http://blog.lotech.org/a-phoenix-plug-for-assigning-template-variables.html"
      }
    ]
  end
end
