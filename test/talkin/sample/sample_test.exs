defmodule Talkin.SampleTest do
  use Talkin.DataCase

  alias Talkin.Sample

  describe "examples" do
    alias Talkin.Sample.Example

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def example_fixture(attrs \\ %{}) do
      {:ok, example} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sample.create_example()

      example
    end

    test "list_examples/0 returns all examples" do
      example = example_fixture()
      assert Sample.list_examples() == [example]
    end

    test "get_example!/1 returns the example with given id" do
      example = example_fixture()
      assert Sample.get_example!(example.id) == example
    end

    test "create_example/1 with valid data creates a example" do
      assert {:ok, %Example{} = example} = Sample.create_example(@valid_attrs)
      assert example.email == "some email"
      assert example.name == "some name"
    end

    test "create_example/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sample.create_example(@invalid_attrs)
    end

    test "update_example/2 with valid data updates the example" do
      example = example_fixture()
      assert {:ok, example} = Sample.update_example(example, @update_attrs)
      assert %Example{} = example
      assert example.email == "some updated email"
      assert example.name == "some updated name"
    end

    test "update_example/2 with invalid data returns error changeset" do
      example = example_fixture()
      assert {:error, %Ecto.Changeset{}} = Sample.update_example(example, @invalid_attrs)
      assert example == Sample.get_example!(example.id)
    end

    test "delete_example/1 deletes the example" do
      example = example_fixture()
      assert {:ok, %Example{}} = Sample.delete_example(example)
      assert_raise Ecto.NoResultsError, fn -> Sample.get_example!(example.id) end
    end

    test "change_example/1 returns a example changeset" do
      example = example_fixture()
      assert %Ecto.Changeset{} = Sample.change_example(example)
    end
  end
end
