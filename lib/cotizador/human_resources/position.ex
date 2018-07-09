defmodule Cotizador.HumanResources.Position do
  use Ecto.Schema
  import Ecto.Changeset


  schema "positions" do
    field :name, :string
    belongs_to :location, Cotizador.Locations.Location

    timestamps()
  end

  @doc false
  def changeset(position, attrs) do
    position
    |> cast(attrs, [:name, :location_id])
    |> validate_required([:name, :location_id])
  end
end
