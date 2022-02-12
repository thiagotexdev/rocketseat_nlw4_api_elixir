defmodule TexpayWeb.UsersView do

  alias Texpay.{Account, User}

  def render("create.json", %{
    user: %User{
      account: %Account{id: account_id, balance: balance},
      id: id,
      name: name,
      nickname: nickname
      }
    }) do
    # devolver um map que representa minha resposta
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }

  end
end
