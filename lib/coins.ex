defmodule Coins do
  @moduledoc """
  Documentation for Coins.
  """

  alias Coins.{
    Commands,
    Transfer,
    Repo,
    Router,
    Schemas
  }

  def mine_coin(account_id, nonce) do
    %Commands.MineCoin{
      account_id: account_id,
      nonce: nonce
    }
    |> Router.dispatch
  end

  def send_coins(from, to, amount) do
    %Commands.SendCoins{
      account_id: from,
      to: to,
      amount: amount,
      transfer_id: UUID.uuid4
    }
    |> Router.dispatch
  end

  def richest do
    import Ecto.Query
    Schemas.Account
    |> order_by(desc: :balance)
    |> limit(1)
    |> Repo.one
  end
end
