# Coins

Coins is an example app using *CQRS* and *Event Sourcing*.

It uses:
* [Commanded](https://github.com/commanded/commanded): Framework to create CQRS/ES appliactions
* [Commanded Ecto Projections](https://github.com/commanded/commanded-ecto-projections): Projections on an Ecto DB
* [Commanded EventStore Adapter](https://github.com/commanded/commanded-eventstore-adapter): EventStore adapter for commanded using postgres

## Using

Setup the databases with `mix setup_db` and then run `iex -S mix`

```elixir
iex> Coins.mine_coin("me", 1)
{:error, :invalid_nonce}

iex> Coins.mine_coin("me", 190)
:ok

iex> Coins.mine_coin("me", 190)
{:error, :used_nonce}

iex> Coins.mine_coin("me", 443)
:ok

iex> Coins.richest |> Map.take([:account_id, :balance])
%{account_id: "me", balance: 1}

iex> [488, 1442, 1597] |> Enum.map(&(Coin.mine_coin("you" &1)))
[:ok, :ok, :ok]

iex> Coins.richest |> Map.take([:account_id, :balance])
%{account_id: "you", balance: 3}

iex> Coins.send_coins("you", "me", 99999)
{:error, :not_enough_coins}

iex> Coins.send_coins("you", "me", 3)
:ok

iex> Coins.richest |> Map.take([:account_id, :balance])
%{account_id: "me", balance: 5}
```
