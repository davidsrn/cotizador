defmodule Cotizador.HumanResources.Headcount do
  use Ecto.Schema
  import Ecto.Changeset


  schema "persons" do
    field :name, :string
    field :salary, :float
    belongs_to :location, Cotizador.Locations.Location
    belongs_to :position, Cotizador.HumanResources.Position

    timestamps()
  end

  @doc false
  def changeset(headcount, attrs) do
    headcount
    |> cast(attrs, [:name, :salary, :location_id, :position_id])
    |> validate_required([:name, :salary, :location_id, :position_id])
  end
end
