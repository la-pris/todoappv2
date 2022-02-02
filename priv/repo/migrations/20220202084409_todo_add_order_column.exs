defmodule Todoapp.Repo.Migrations.TodoAddOrderColumn do
  use Ecto.Migration

  def change do
    alter table("items") do
      add :order, :float
    end
  end
end
