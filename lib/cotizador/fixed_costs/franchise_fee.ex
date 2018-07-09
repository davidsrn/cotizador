defmodule Cotizador.FixedCosts.FranchiseFee do
  use Ecto.Schema
  import Ecto.Changeset


  schema "franchise_fees" do
    field :name, :string
    field :value, :string
    belongs_to :location, Cotizador.Locations.Location

    timestamps()
  end

  @doc false
  def changeset(franchise_fee, attrs) do
    franchise_fee
    |> cast(attrs, [:name, :value, :location_id])
    |> validate_required([:name, :value, :location_id])
  end
end
