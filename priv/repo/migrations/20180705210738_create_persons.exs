defmodule Cotizador.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :name, :string
      add :salary, :float
      add :location_id, references(:locations, on_delete: :nothing)
      add :position_id, references(:positions, on_delete: :nothing)

      timestamps()
    end

    create index(:persons, [:location_id])
    create index(:persons, [:position_id])
  end
end
