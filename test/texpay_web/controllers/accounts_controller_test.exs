defmodule TexpayWeb.AccountsControllerTest do

  use TexpayWeb.ConnCase, async: true

  alias Texpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Thiago",
        password: "123456",
        nickname: "texugo",
        email: "thiago@texdev.com.br",
        age: 37
      }

      {:ok, %User{account: %Account{id: account_id}}} = Texpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic dGV4ZGV2OjEyMzQ1Ng==")

      #uma tupla
      {:ok, conn: conn , account_id: account_id}

    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
       # enviar um map
       params = %{"value" => "50.00"}
        response =
          conn
            |> post(Routes.accounts_path(conn, :deposit, account_id, params))
            |> json_response(:ok)

        assert %{
          "account" => %{"balance" => "50.00", "id" => _id_},
          "message" => "Ballance changed successfully"
        } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      # enviar um map
      params = %{"value" => "banana"}
       response =
         conn
           |> post(Routes.accounts_path(conn, :deposit, account_id, params))
           |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value!"}

      assert response == expected_response
   end

  end
end
