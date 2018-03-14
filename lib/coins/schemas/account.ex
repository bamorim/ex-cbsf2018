defmodule Coins.Schemas.Account do
  use Ecto.Schema

  @primary_key false

  schema "accounts" do
    field(:account_id, :string)
    field(:balance, :integer)
  end
end
