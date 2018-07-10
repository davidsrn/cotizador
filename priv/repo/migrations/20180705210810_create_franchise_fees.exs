defmodule Cotizador.Repo.Migrations.CreateFranchiseFees do
  use Ecto.Migration

  def change do
    create table(:franchise_fees) do
      add :name, :string
      add :value, :float
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:franchise_fees, [:location_id])
  end
end
