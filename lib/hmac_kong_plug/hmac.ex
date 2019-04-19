defmodule HmacKongPlug.Hmac do
  def signature(date, secret) do
    data = "date: #{formatted_date(date)}\nGET /requests HTTP/1.1"
    :crypto.hmac(:sha256, secret, data)
    |> Base.encode64
  end

  def formatted_date(date) do
    Timex.format!(date, "%a, %d %b %Y %H:%M:%S GMT", :strftime)
  end
end
