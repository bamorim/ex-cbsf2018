defmodule Proof do
  # Just to help find the valid nonces
  def nonces(string, amount, difficulty \\ 1) do
    1
    |> Stream.iterate(&(&1 + 1))
    |> Stream.filter(&(proof(string, &1, difficulty)))
    |> Enum.take(amount)
  end

  def proof(string, nonce, difficulty \\ 1) do
    String.starts_with?(
      hash( hash(string) <> hash(to_string(nonce)) ),
      header(difficulty)
    )
  end

  defp header(difficulty) do
    [<<0>>]
    |> Stream.cycle
    |> Enum.take(difficulty)
    |> Enum.join("")
  end

  defp hash(x), do: :crypto.hash(:sha256, x)
end
