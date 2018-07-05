defmodule Cotizador.FixedCosts.FranchiseFee do
  use Ecto.Schema
  import Ecto.Changeset


  schema "franchise_fees" do
    field :name, :string
    field :value, :string
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(franchise_fee, attrs) do
    franchise_fee
    |> cast(attrs, [:name, :value])
    |> validate_required([:name, :value])
  end
end
