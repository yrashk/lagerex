defmodule Lagerex.MixFile do
  use Mix.Project

  def project do
    [app: :lagerex,
     project: "Lagerex", version: "0.1", 
     deps: deps,
     compile_options: [ignore_module_conflict: true, docs: true]]
  end

  def application, do: []

  defp deps do
    [{:lager, %r(.*), git: "https://github.com/basho/lager"}]
  end

end
