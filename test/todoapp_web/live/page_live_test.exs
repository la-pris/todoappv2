defmodule TodoappWeb.PageLiveTest do
  use TodoappWeb.ConnCase

  import Phoenix.LiveViewTest

  test "connected mount", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/items")
    assert html =~ "<h1>Listing Items</h1>"
  end
end
