defmodule Cotizador.FixedCosts.Operation do
  use Ecto.Schema
  import Ecto.Changeset


  schema "operations" do
    field :date, :date
    field :detail, :string
    field :item, :string
    field :monthly_cost, :float
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(operation, attrs) do
    operation
    |> cast(attrs, [:item, :detail, :monthly_cost, :date])
    |> validate_required([:item, :detail, :monthly_cost, :date])
  end
end
