defmodule Texpay.Accounts.Deposit do

  alias Texpay.Accounts.Operation
  alias Texpay.Repo

  def call(params) do
    params
    |> Operation.call(:deposit)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      # rodando os testes , achamos um bug na app, vou manter comentado este bug
      #{:ok, %{account_deposit: account}} -> {:ok, account}
      {:ok, %{deposit: account} = map} ->
        IO.inspect(map)
        {:ok, account}
    end
  end

end
