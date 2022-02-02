defmodule TodoappWeb.ItemLive.Index do
  use TodoappWeb, :live_view

  alias Todoapp.Todo
  alias Todoapp.Todo.Item
  # @topic "live"
  # alias TodoappWeb.Router

  @impl true
  def mount(_params, _session, socket) do
    # IO.inspect(socket)
    # sorteditems = Enum.sort(list_items(), :desc)
    # {:ok, assign(socket, :items, sorteditems)}
    # assign(socket, :changeset, Item.changeset(%Item{}, ),)
    {:ok, assign(socket, :items, list_items())}

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
  def handle_event("validate", %{"item" => item_params}, socket) do
    changeset =
      socket.assigns.item
      |> Todo.change_item(item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"item" => item_params}, socket) do
    save_item(socket, socket.assigns.action, item_params)
  end

    # @impl true
    # def handle_event("create", %{"item" => item_params}, socket) do
    #   Item.create_item(item_params)
    #   socket = assign(socket, items: Item.list_items(), active: %Item{})
    #   TodoappWeb.Endpoint.broadcast_from(self(), @topic, "update", socket.assigns)
    #   {:noreply, socket}
    # end


    # Item.create_item(%{text: text})F
    # {:ok, item} = Item.create_item(%{text: text})
    # items = socket.assigns.items
    # items = items ++ [item]
    # socket = assign(socket, items: Item.list_items(), active: %Item{})
    # IO.inspect(socket)
    # TodoappWeb.Endpoint.broadcast_from(self(), @topic, "update", socket.assigns)
    # {:noreply, socket}

    # {:noreply, assign(socket, :items, list_items())}
  # @impl true
  # def handle_event("save", %{"item" => item_params}, socket) do
  #   case Todo.create_item(item_params) do
  #     {:ok, item} ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "user created")
  #       |> redirect(to: "/index")}
  #       #  |> redirect(to: /index Routes.item_index_path(TodoappWeb.Endpoint, TodoappWeb.I, item))}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, changeset: changeset)}
  #     end
  # end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = Todo.get_item!(id)
    {:ok, _} = Todo.delete_item(item)

    {:noreply, assign(socket, :items, list_items())}
  end

  defp save_item(socket, :new, item_params) do
    case Todo.create_item(item_params) do
      {:ok, _item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end


  defp list_items do
    Todo.list_items()
  end
end
