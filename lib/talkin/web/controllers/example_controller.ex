defmodule Talkin.Web.ExampleController do
  use Talkin.Web, :controller

  alias Talkin.Sample

  def index(conn, _params) do
    examples = Sample.list_examples()
    render(conn, "index.html", examples: examples)
  end

  def new(conn, _params) do
    changeset = Sample.change_example(%Talkin.Sample.Example{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"example" => example_params}) do
    case Sample.create_example(example_params) do
      {:ok, example} ->
        conn
        |> put_flash(:info, "Example created successfully.")
        |> redirect(to: example_path(conn, :show, example))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    example = Sample.get_example!(id)
    render(conn, "show.html", example: example)
  end

  def edit(conn, %{"id" => id}) do
    example = Sample.get_example!(id)
    changeset = Sample.change_example(example)
    render(conn, "edit.html", example: example, changeset: changeset)
  end

  def update(conn, %{"id" => id, "example" => example_params}) do
    example = Sample.get_example!(id)

    case Sample.update_example(example, example_params) do
      {:ok, example} ->
        conn
        |> put_flash(:info, "Example updated successfully.")
        |> redirect(to: example_path(conn, :show, example))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", example: example, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    example = Sample.get_example!(id)
    {:ok, _example} = Sample.delete_example(example)

    conn
    |> put_flash(:info, "Example deleted successfully.")
    |> redirect(to: example_path(conn, :index))
  end
end
