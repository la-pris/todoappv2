defmodule Todoapp.Todo.Item do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> validate_required([:text, :person_id, :status])
  end
end
