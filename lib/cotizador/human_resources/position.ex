defmodule Cotizador.HumanResources.Position do
  use Ecto.Schema
  import Ecto.Changeset


  schema "positions" do
    field :name, :string
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(position, attrs) do
    position
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
