defmodule Talkin.Repo.Migrations.CreateTalkin.Sample.Example do
  use Ecto.Migration

  def change do
    create table(:sample_examples) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
