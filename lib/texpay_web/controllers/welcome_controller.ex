defmodule TexpayWeb.WelcomeController do
  use TexpayWeb, :controller

  # utilizando o alias para dar um nome ao módulo.
  alias Texpay.Numbers

  # via pattern matching, salvar o valor em uma variável.
  # def index(conn, _params) do
  def index(conn, %{"filename" => filename}) do

    # text(conn, "Welcome to the Texpay API")
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)

  end

  # struct é um map com nome
  # IO.inspect permite ver o valor da conexão no terminal

  defp handle_response({:ok , %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> IO.inspect()
    |> json(%{message: "Welcome to Texpay API. Here is your number #{result}"})
  end

  defp handle_response({:error , reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> IO.inspect()
    |> json(reason)
  end

end
