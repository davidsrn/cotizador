defmodule Cotizador.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset


  schema "projects" do
    field :fixed_mxn, :float
    field :fixed_usd, :float
    field :flat_mxn, :float
    field :flat_usd, :float
    field :name, :string
    field :total_margin_mxn, :float
    field :total_margin_usd, :float
    field :total_mxn, :float
    field :total_usd, :float
    field :variable_mxn, :float
    field :variable_usd, :float

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :flat_mxn, :fixed_mxn, :variable_mxn, :total_mxn, :total_margin_mxn, :flat_usd, :fixed_usd, :variable_usd, :total_usd, :total_margin_usd])
    |> validate_required([:name, :flat_mxn, :fixed_mxn, :variable_mxn, :total_mxn, :total_margin_mxn, :flat_usd, :fixed_usd, :variable_usd, :total_usd, :total_margin_usd])
  end
end
