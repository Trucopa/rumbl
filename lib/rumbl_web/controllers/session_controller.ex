defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case RumblWeb.Auth.login_by_username_and_pass(conn, user, pass, repo: Rumbl.Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome Back!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
