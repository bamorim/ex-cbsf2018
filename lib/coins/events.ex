defmodule Coins.Events do
  defmodule CoinMined do
    defstruct [
      :account_id,
      :nonce
    ]
  end

  defmodule CoinsSent do
    defstruct [
      :account_id,
      :to,
      :amount,
      :transfer_id
    ]
  end

  defmodule CoinsReceived do
    defstruct [
      :account_id,
      :amount,
      :transfer_id
    ]
  end
end
