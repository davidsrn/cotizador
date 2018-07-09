defmodule Cotizador.FixedCosts.Operation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "operations" do
    field :date, :date
    field :detail, :string
    field :item, :string
    field :monthly_cost, :float
    belongs_to :location, Cotizador.Locations.Location

    timestamps()
  end

  @doc false
  def changeset(operation, attrs) do
    operation
    |> cast(attrs, [:item, :detail, :monthly_cost, :date, :location_id])
    |> validate_required([:item, :detail, :monthly_cost, :date, :location_id])
  end
end
