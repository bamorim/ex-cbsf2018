defmodule Coins.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    Coins.Supervisor.start_link(args)
  end
end
