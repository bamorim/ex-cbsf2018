defmodule Coins.Account do
  alias __MODULE__

  alias Coins.Commands.{
    MineCoin,
    ReceiveCoins,
    SendCoins
  }

  alias Coins.Events.{
    CoinMined,
    CoinsSent,
    CoinsReceived
  }

  defstruct [balance: 0, last_nonce: 0]

  def execute(%{last_nonce: ln}, %MineCoin{nonce: n})
    when n < ln, do: {:error, :used_nonce}

  def execute(_, %MineCoin{} = cmd) do
    if Proof.proof(cmd.account_id, cmd.nonce) do
      %CoinMined{
        account_id: cmd.account_id,
        nonce: cmd.nonce
      }
    else
      {:error, :invalid_nonce}
    end
  end

  def execute(%{balance: b}, %SendCoins{amount: a}) when a > b,
    do: {:error, :not_enough_coins}

  def execute(_, %SendCoins{} = cmd) do
    %CoinsSent{
      account_id: cmd.account_id,
      to: cmd.to,
      amount: cmd.amount,
      transfer_id: cmd.transfer_id
    }
  end

  def execute(_, %ReceiveCoins{} = cmd) do
    %CoinsReceived{
      account_id: cmd.account_id,
      amount: cmd.amount,
      transfer_id: cmd.transfer_id
    }
  end

  def apply(state, %CoinMined{} = evt) do
    %Account{ state | last_nonce: evt.nonce }
    |> increase_balance(1)
  end

  def apply(state, %CoinsSent{} = evt) do
    increase_balance(state, -evt.amount)
  end

  def apply(state, %CoinsReceived{} = evt) do
    increase_balance(state, evt.amount)
  end

  defp increase_balance(state, amount) do
    %Account{state | balance: state.balance + amount}
  end
end
