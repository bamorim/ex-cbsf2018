defmodule Coins.SendCoinsProcess do
  use Commanded.ProcessManagers.ProcessManager,
    name: "SendCoinsProcess",
    router: Coins.Router

  alias Coins.Commands, as: C
  alias Coins.Events, as: E

  defstruct []

  def interested?(%E.CoinsSent{transfer_id: id}) do
    {:start, id}
  end

  def interested?(%E.CoinsReceived{transfer_id: id}) do
    {:stop, id}
  end

  def handle(_, %E.CoinsSent{} = evt) do
    %C.ReceiveCoins{
      transfer_id: evt.transfer_id,
      account_id: evt.to,
      amount: evt.amount
    }
  end

  def apply(state, _event), do: state
end
