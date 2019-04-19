defmodule HmacKongPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "returns unauthorized http status when there is no authentication header" do
    opts = HmacKongPlug.init([])

    conn =
      :get
      |> conn("/")
      |> HmacKongPlug.call(opts)

    assert %Plug.Conn{status: 401} = conn
  end

  test "returns unauthorized http status when the header `date` is not present" do
    opts = HmacKongPlug.init([])

    conn =
      :get
      |> conn("/")
      |> Plug.Conn.put_req_header("authorization", "mac username=test headers=\"date\" signature=\"123\"")
      |> HmacKongPlug.call(opts)

    assert %Plug.Conn{status: 401} = conn
  end

  test "returns unauthorized http status when the authorization header does not match the specification" do
    opts = HmacKongPlug.init([])

    conn =
      :get
      |> conn("/")
      |> Plug.Conn.put_req_header("authorization", "123")
      |> Plug.Conn.put_req_header("date", "date")
      |> HmacKongPlug.call(opts)

    assert %Plug.Conn{status: 401} = conn
  end
end
