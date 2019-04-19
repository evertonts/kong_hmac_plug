defmodule HmacKongPlug.HmacTest do
  use ExUnit.Case, async: true

  test "calculate the signature based on the date" do
    date = Timex.parse!("Thu, 22 Jun 2017 17:15:21 GMT", "%a, %d %b %Y %H:%M:%S GMT", :strftime)
    IO.inspect date
    assert HmacKongPlug.Hmac.signature(date, "secret") == "ujWCGHeec9Xd6UD2zlyxiNMCiXnDOWeVFMu5VeRUxtw="
  end
end
