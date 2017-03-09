defmodule WebgeeksRaffle.PageController do
  use WebgeeksRaffle.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
