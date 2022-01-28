defmodule TodoappWeb.TodoLive do
  use TodoappWeb, :live_view

  alias Todoapp.Todo.Item

  @topic "live"

  # Things I need to do
  # create a render function,
  # mount function
  # handle_event
  # draggable class

  @impl true
  def mount(_params, _session, socket) do
    #this is a map with a key of todo
    if connected?(socket), do: TodoappWeb.Endpoint.subscribe(@topic)
    {:ok, assign(socket, items: Item.list_items())}
  end

  @impl true
  def handle_event("create", %{"text" => text}, socket) do
    Item.create_item(%{text: text})
    socket = assign(socket, items: Item.list_items(), active: %Item{})
    TodoappWeb.Endpoint.broadcast_from(self(), @topic, "update", socket.assigns)
    {:noreply, socket}
  end

  # def render(assigns) do
  #   #pwede mag sigil na lang and do the template here
  #   Phoenix.View.render(TodoappWeb.PageView, "index", assigns)
  # end

  @impl true
  def handle_info(%{event: "update", payload: %{items: items}}, socket) do
    {:noreply, assign(socket, items: items)}
  end

  @impl true
  def handle_event("delete", data, socket) do
    Item.delete_item(Map.get(data, "id"))
    socket = assign(socket, items: Item.list_items(), active: %Item{})
    TodoappWeb.Endpoint.broadcast_from(self(), @topic, "update", socket.assigns)
    {:noreply, socket}
  end
end
