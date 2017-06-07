defmodule Talkin.RoomManager.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Talkin.RoomManager.Room


  schema "room_manager_rooms" do
    field :description, :string
    field :encrypted_password, :string
    field :last_access, :naive_datetime
    field :name, :string
    field :registered_date, :naive_datetime
    field :visible, :boolean, default: false
    field :owner_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :description, :encrypted_password, :visible, :registered_date, :last_access])
    |> validate_required([:name, :description, :encrypted_password, :visible, :registered_date, :last_access])
  end
end
