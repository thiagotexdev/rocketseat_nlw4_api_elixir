defmodule TexpayWeb.UsersController do
  use TexpayWeb, :controller


  alias Texpay.User

  action_fallback TexpayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Texpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
    # params
    # |> Texpay.create_user()
    # |> handle_response(conn)

  end


  # defp handle_response({:ok , %User{} = user}, conn) do
  #  conn
  #  |> put_status(:created)
  #  |> render("create.json", user: user)
  # end

  # defp handle_response({:error , _result} = error , _conn), do: error

end
