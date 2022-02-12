defmodule TexpayWeb.FallbackController do
  use TexpayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(TexpayWeb.ErrorView)
    |> render("400.json", result: result)
  end

end
