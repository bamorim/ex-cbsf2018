defmodule Coins.Commands do
  defmodule MineCoin do
    defstruct [
      :account_id,
      :nonce
    ]
  end

  defmodule SendCoins do
    defstruct [
      :account_id,
      :to,
      :amount,
      :transfer_id
    ]
  end

  defmodule ReceiveCoins do
    defstruct [
      :account_id,
      :amount,
      :transfer_id
    ]
  end
end
