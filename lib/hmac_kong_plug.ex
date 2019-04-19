require IEx
defmodule HmacKongPlug do
  import Plug.Conn

  def init(options) do
    IO.inspect(options)
    options
  end

  def call(conn, _opts) do
    with [auth] <- Plug.Conn.get_req_header(conn, "authorization"),
         [date] <- Plug.Conn.get_req_header(conn, "date") do

      case parse_authorization_header(auth) do
        {:ok, lala} ->
          conn
        {:error, error} ->
          Plug.Conn.put_status(conn, 401)
      end
    else
      _ -> Plug.Conn.put_status(conn, 401)
    end
  end

  def parse_authorization_header(auth) do
    IO.inspect auth
    with [username, algorithm, headers, signature] <- String.split(auth, ",") do
      {:ok, ""}
    else
      error -> {:error, error}
    end
  end
end
