defmodule Texpay.Accounts.Withdraw do

  alias Texpay.Accounts.Operation
  alias Texpay.Repo

  def call(params) do
    params
    |> Operation.call(:withdraw)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      # bug encontrado e corrigido, mantive a linha sem o bug pra poder verificar a diferença.
      # {:ok, %{account_withdraw: account}} -> {:ok, account}
      {:ok, %{withdraw: account}} -> {:ok, account}
    end
  end

end
