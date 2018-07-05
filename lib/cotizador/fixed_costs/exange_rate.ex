defmodule Cotizador.FixedCosts.ExangeRate do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rates" do
    field :amout, :string
    field :date, :date

    timestamps()
  end

  @doc false
  def changeset(exange_rate, attrs) do
    exange_rate
    |> cast(attrs, [:amout, :date])
    |> validate_required([:amout, :date])
  end
end
