defmodule TodoappWeb.TodoLive do
  use TodoappWeb, :live_view

  alias Todoapp.Todo

  def mount(_params, _session, socket) do
    {:ok, assign(socket, todo: Todo.list_items())}
  end

  def render(assigns) do
    ~L"Rendering LiveView"
  end
end
