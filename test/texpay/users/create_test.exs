defmodule Texpay.Users.CreateTest do
  # use Texpay.DataCase
  use Texpay.DataCase, async: true

  alias Texpay.User
  alias Texpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Thiago",
        password: "123456",
        nickname: "texugo",
        email: "thiago@texdev.com.br",
        age: 37
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Thiago", age: 37, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Thiago",
        password: "123456",
        nickname: "texugo",
        email: "thiago@texdev.com.br",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{

        age: ["must be greater than or equal to 18"]

      }


      assert errors_on(changeset) == expected_response
    end

  end

end
