defmodule Texpay.User do
  #schema não é um model, mas é um mapeamento de dados, não tem comportamento
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Texpay.Account

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email , :string
    field :password, :string, virtual: true
    field :password_hash , :string
    field :nickname, :string
    has_one :account, Account

    timestamps()
  end

  # o changeset mapeia dados e valida dados.
  def changeset(params) do
    # {} é uma struct vazia.
    %__MODULE__{}
    |> cast(params, @required_params)
    # |> IO.inspect()
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # testei trocar a criptografia porque o Bcrypt_elixir não funcionou no ambiente Windows.
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset

end
