defmodule Texpay.Account do
  #schema não é um model, mas é um mapeamento de dados, não tem comportamento
  use Ecto.Schema
  import Ecto.Changeset

  alias Texpay.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  # o changeset mapeia dados e valida dados.
  def changeset(struct \\ %__MODULE__{}, params) do
    # {} é uma struct vazia.
    struct
    |> cast(params, @required_params)
    # |> IO.inspect()
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end

end
