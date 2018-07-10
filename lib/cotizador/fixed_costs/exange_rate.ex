defmodule Cotizador.FixedCosts.ExangeRate do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rates" do
    field :amount, :float
    field :date, :date

    timestamps()
  end

  @doc false
  def changeset(exange_rate, attrs) do
    exange_rate
    |> cast(attrs, [:amount, :date])
    |> validate_required([:amount, :date])
  end
end
