defmodule Felixir.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :description, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:rooms, [:name])
    create index(:rooms, [:user_id])
  end
end
