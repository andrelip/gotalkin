defmodule Talkin.RoomManagerTest do
  use Talkin.DataCase

  alias Talkin.RoomManager

  describe "rooms" do
    alias Talkin.RoomManager.Room

    @valid_attrs %{description: "some description", encrypted_password: "some encrypted_password", last_access: ~N[2010-04-17 14:00:00.000000], name: "some name", registered_date: ~N[2010-04-17 14:00:00.000000], visible: true}
    @update_attrs %{description: "some updated description", encrypted_password: "some updated encrypted_password", last_access: ~N[2011-05-18 15:01:01.000000], name: "some updated name", registered_date: ~N[2011-05-18 15:01:01.000000], visible: false}
    @invalid_attrs %{description: nil, encrypted_password: nil, last_access: nil, name: nil, registered_date: nil, visible: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RoomManager.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert RoomManager.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert RoomManager.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = RoomManager.create_room(@valid_attrs)
      assert room.description == "some description"
      assert room.encrypted_password == "some encrypted_password"
      assert room.last_access == ~N[2010-04-17 14:00:00.000000]
      assert room.name == "some name"
      assert room.registered_date == ~N[2010-04-17 14:00:00.000000]
      assert room.visible == true
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RoomManager.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, room} = RoomManager.update_room(room, @update_attrs)
      assert %Room{} = room
      assert room.description == "some updated description"
      assert room.encrypted_password == "some updated encrypted_password"
      assert room.last_access == ~N[2011-05-18 15:01:01.000000]
      assert room.name == "some updated name"
      assert room.registered_date == ~N[2011-05-18 15:01:01.000000]
      assert room.visible == false
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = RoomManager.update_room(room, @invalid_attrs)
      assert room == RoomManager.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = RoomManager.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> RoomManager.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = RoomManager.change_room(room)
    end
  end
end
