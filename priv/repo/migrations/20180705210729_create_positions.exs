defmodule Cotizador.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions) do
      add :name, :string
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:positions, [:location_id])
  end
end
