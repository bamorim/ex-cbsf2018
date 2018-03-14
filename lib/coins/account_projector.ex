defmodule Coins.AccountProjector do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias Coins.Events, as: E
  alias Coins.Schemas, as: S

  project %E.CoinMined{} = evt do
    increase_balance(multi, evt.account_id, 1)
  end

  project %E.CoinsSent{} = evt do
    increase_balance(multi, evt.account_id, -evt.amount)
  end

  project %E.CoinsReceived{} = evt do
    increase_balance(multi, evt.account_id, evt.amount)
  end

  defp increase_balance(multi, account_id, amount) do
    Ecto.Multi.insert(
      multi,
      :increase_balance,
      %S.Account{account_id: account_id, balance: amount},
      conflict_target: :account_id,
      on_conflict: [inc: [balance: amount]]
    )
  end
end
