defmodule Cotizador.FixedCosts.GrowthAndCulture do
  use Ecto.Schema
  import Ecto.Changeset


  schema "growth_and_culture_item" do
    field :date, :date
    field :detail, :string
    field :name, :string
    field :yearly_cost, :string
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(growth_and_culture, attrs) do
    growth_and_culture
    |> cast(attrs, [:name, :detail, :yearly_cost, :date])
    |> validate_required([:name, :detail, :yearly_cost, :date])
  end
end
