defmodule Talkin.AccountsTest do
  use Talkin.DataCase

  alias Talkin.Accounts

  describe "users" do
    alias Talkin.Accounts.User

    @valid_attrs %{email: "some email", name: "some name", password: "mypass"}
    @update_attrs %{email: "some updated email", name: "some updated name", password: "mypass"}
    @invalid_attrs %{email: nil, name: nil, password_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() |> remove_password_hash() == [user] |> remove_password_hash()
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      user_from_db = Accounts.get_user!(user.id)
      assert remove_password_hash(user) == remove_password_hash(user_from_db)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.name == "some updated name"
      assert user.password_hash != nil
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      user_from_db = Accounts.get_user!(user.id)
      assert remove_password_hash(user) == remove_password_hash(user_from_db)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    defp remove_password_hash(items) when is_list(items) do
      items |> Enum.map(fn item -> Map.delete(item, :password) end)
    end

    defp remove_password_hash(item) do
      Map.delete(item, :password)
    end
  end
end
