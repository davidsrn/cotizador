defmodule Cotizador.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :cost, :float
      add :initial_date, :date
      add :final_date, :date
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:items, [:location_id])
  end
end
