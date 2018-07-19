defmodule Cotizador.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :flat_mxn, :float
      add :fixed_mxn, :float
      add :variable_mxn, :float
      add :total_mxn, :float
      add :total_margin_mxn, :float
      add :flat_usd, :float
      add :fixed_usd, :float
      add :variable_usd, :float
      add :total_usd, :float
      add :total_margin_usd, :float

      timestamps()
    end

  end
end
