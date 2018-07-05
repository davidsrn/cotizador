defmodule Cotizador.HumanResources.Headcount do
  use Ecto.Schema
  import Ecto.Changeset


  schema "persons" do
    field :name, :string
    field :salary, :float
    field :location_id, :id
    field :position_id, :id

    timestamps()
  end

  @doc false
  def changeset(headcount, attrs) do
    headcount
    |> cast(attrs, [:name, :salary])
    |> validate_required([:name, :salary])
  end
end
