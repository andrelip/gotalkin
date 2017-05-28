defmodule Talkin.Web.ExampleControllerTest do
  use Talkin.Web.ConnCase

  alias Talkin.Sample

  @create_attrs %{email: "some email", name: "some name"}
  @update_attrs %{email: "some updated email", name: "some updated name"}
  @invalid_attrs %{email: nil, name: nil}

  def fixture(:example) do
    {:ok, example} = Sample.create_example(@create_attrs)
    example
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, example_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Examples"
  end

  test "renders form for new examples", %{conn: conn} do
    conn = get conn, example_path(conn, :new)
    assert html_response(conn, 200) =~ "New Example"
  end

  test "creates example and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, example_path(conn, :create), example: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == example_path(conn, :show, id)

    conn = get conn, example_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Example"
  end

  test "does not create example and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, example_path(conn, :create), example: @invalid_attrs
    assert html_response(conn, 200) =~ "New Example"
  end

  test "renders form for editing chosen example", %{conn: conn} do
    example = fixture(:example)
    conn = get conn, example_path(conn, :edit, example)
    assert html_response(conn, 200) =~ "Edit Example"
  end

  test "updates chosen example and redirects when data is valid", %{conn: conn} do
    example = fixture(:example)
    conn = put conn, example_path(conn, :update, example), example: @update_attrs
    assert redirected_to(conn) == example_path(conn, :show, example)

    conn = get conn, example_path(conn, :show, example)
    assert html_response(conn, 200) =~ "some updated email"
  end

  test "does not update chosen example and renders errors when data is invalid", %{conn: conn} do
    example = fixture(:example)
    conn = put conn, example_path(conn, :update, example), example: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Example"
  end

  test "deletes chosen example", %{conn: conn} do
    example = fixture(:example)
    conn = delete conn, example_path(conn, :delete, example)
    assert redirected_to(conn) == example_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, example_path(conn, :show, example)
    end
  end
end
