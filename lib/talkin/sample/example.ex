defmodule Talkin.Sample.Example do
  use Ecto.Schema
  import Ecto.Changeset
  alias Talkin.Sample.Example


  schema "sample_examples" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Example{} = example, attrs) do
    example
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
