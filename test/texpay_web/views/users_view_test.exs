defmodule TexpayWeb.UsersViewTest do

  use TexpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Texpay.{Account, User}
  alias TexpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Thiago",
      password: "123456",
      nickname: "texugo",
      email: "thiago@texdev.com.br",
      age: 37
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Texpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    # assert "banana" == response

    expected_response =  %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          # id: "3b970fb4-e25a-4f09-ab57-53d6ad3feced"
          id: account_id
        },
        # id: "6da669d4-65f6-41c0-9e5b-1d47285cb79b",
        id: user_id,
        name: "Thiago",
        nickname: "texugo"
      }
    }

    assert expected_response == response

  end


end
