defmodule Cotizador.Repo.Migrations.CreateGrowthAndCultureItem do
  use Ecto.Migration

  def change do
    create table(:growth_and_culture_item) do
      add :name, :string
      add :detail, :string
      add :yearly_cost, :integer
      add :date, :date
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:growth_and_culture_item, [:location_id])
  end
end
