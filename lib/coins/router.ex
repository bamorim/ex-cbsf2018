defmodule Coins.Router do
  use Commanded.Commands.Router

  alias Coins.Account
  alias Coins.Commands, as: C

  dispatch(
    [
      C.MineCoin,
      C.SendCoins,
      C.ReceiveCoins
    ],
    to: Account,
    identity: :account_id
  )
end
