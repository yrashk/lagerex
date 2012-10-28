defmodule Lager do
  levels = [:debug, :info, :notice, :warning, :error, :critical, :alert, :emergency]

  lc level inlist levels do
    contents =
    quote do
      def unquote(level).(msg) do
        log(unquote(level), to_char_list(msg))
      end
      def unquote(level).(format, args)  do
        log(unquote(level), format, args)
      end
    end
    Module.eval_quoted __MODULE__, contents, file: __FILE__, line: __ENV__.line
  end

  def start do
    apps = [:sasl, :compiler, :syntax_tools, :lager, :lagerex]
    lc app inlist apps do
      :ok = :application.start app
    end
  end
  
  def log(level, msg), do: :lager.log(level, Process.self, msg)
  def log(level, format, args) when is_list(format), do: :lager.log(level, Process.self, format, args)
  def log(level, format, args) when is_binary(format), do: log(level, binary_to_list(format), args)

end
