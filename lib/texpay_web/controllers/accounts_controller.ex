defmodule TexpayWeb.AccountsController do
  use TexpayWeb, :controller


  alias Texpay.Account
  alias Texpay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback TexpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Texpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Texpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    # exemplo de uso de task
    # task = Task.async(fn -> Texpay.transaction(params) end)

    # with {:ok, %TransactionResponse{} = transaction} <- Task.await(task) do
    with {:ok, %TransactionResponse{} = transaction} <- Texpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end

end
