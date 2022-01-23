defmodule Todoapp.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todoapp.Todo` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        person_id: 42,
        status: "some status",
        text: "some text"
      })
      |> Todoapp.Todo.create_item()

    item
  end
end
