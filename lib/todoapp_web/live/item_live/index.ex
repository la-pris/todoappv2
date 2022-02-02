defmodule TodoappWeb.ItemLive.Index do
  use TodoappWeb, :live_view

  alias Todoapp.Todo
  alias Todoapp.Todo.Item

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(socket)
    sorteditems = Enum.sort(list_items(), :desc)
    {:ok, assign(socket, :items, sorteditems)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Item")
    |> assign(:item, Todo.get_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item")
    |> assign(:item, %Item{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Items")
    |> assign(:item, nil)
  end

  @impl true
  def handle_event("create", %{"text" => text}, socket) do
    # Todo.create_item(%{text: text})
    # socket = assign(socket, items: Todo.list_items(), active: %Todo{})



    # Item.create_item(%{text: text})F
    # {:ok, item} = Item.create_item(%{text: text})
    # items = socket.assigns.items
    # items = items ++ [item]
    # socket = assign(socket, items: Item.list_items(), active: %Item{})
    # IO.inspect(socket)
    # TodoappWeb.Endpoint.broadcast_from(self(), @topic, "update", socket.assigns)
    # {:noreply, socket}

    # {:noreply, assign(socket, :items, list_items())}

  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = Todo.get_item!(id)
    {:ok, _} = Todo.delete_item(item)

    {:noreply, assign(socket, :items, list_items())}
  end

  defp list_items do
    Todo.list_items()
  end
end
