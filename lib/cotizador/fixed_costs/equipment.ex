defmodule Cotizador.FixedCosts.Equipment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :cost, :string
    field :final_date, :date
    field :initial_date, :date
    field :name, :string
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(equipment, attrs) do
    equipment
    |> cast(attrs, [:name, :cost, :initial_date, :final_date])
    |> validate_required([:name, :cost, :initial_date, :final_date])
  end
end
