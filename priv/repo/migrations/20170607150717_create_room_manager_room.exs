defmodule Talkin.Repo.Migrations.CreateTalkin.RoomManager.Room do
  use Ecto.Migration

  def change do
    create table(:room_manager_rooms) do
      add :name, :string
      add :description, :string
      add :encrypted_password, :string
      add :visible, :boolean, default: false, null: false
      add :registered_date, :naive_datetime
      add :last_access, :naive_datetime
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:room_manager_rooms, [:owner_id])
  end
end
