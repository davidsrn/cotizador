defmodule Cotizador.Repo.Migrations.CreateOperations do
  use Ecto.Migration

  def change do
    create table(:operations) do
      add :item, :string
      add :detail, :string
      add :monthly_cost, :float
      add :date, :date
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:operations, [:location_id])
  end
end
