defmodule Texpay.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table :accounts do
      add :balance, :decimal
      add :user_id, references(:users, type: :binary_id)

      timestamps()
    end
    #constraints é pra extender funções, garantindo lógica de dados
    create constraint(:accounts, :balance_must_be_positive_or_zero, check: "balance >= 0")
  end
end
