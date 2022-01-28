defmodule Todoapp.Todo.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Todoapp.Repo
  alias __MODULE__

  schema "items" do
    field :person_id, :integer
    field :status, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text, :person_id, :status])
    |> validate_required([:text])
  end

  def create_item(attrs \\ %{}) do
    %Item{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def get_item!(id), do: Repo.get!(Item, id)

  def list_items do
    Repo.all(Item)
  end

  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end
end
