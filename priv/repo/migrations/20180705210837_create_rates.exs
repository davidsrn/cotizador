defmodule Cotizador.Repo.Migrations.CreateRates do
  use Ecto.Migration

  def change do
    create table(:rates) do
      add :amout, :string
      add :date, :date

      timestamps()
    end

  end
end
