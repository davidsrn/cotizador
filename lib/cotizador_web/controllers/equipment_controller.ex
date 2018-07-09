defmodule CotizadorWeb.EquipmentController do
  use CotizadorWeb, :controller

  alias Cotizador.FixedCosts
  alias Cotizador.FixedCosts.Equipment
  alias Cotizador.Repo
  import Ecto.Query, warn: false
  alias Cotizador.Locations.Location

  def index(conn, _params) do
    items = FixedCosts.list_items()
    render(conn, "index.html", items: items)
  end

  def new(conn, _params) do
    changeset = FixedCosts.change_equipment(%Equipment{})
    query = from loc in Location,
            select: {loc.name, loc.id}
    location_select = Repo.all(query)
    render(conn, "new.html", changeset: changeset, locations: location_select)
  end

  def create(conn, %{"equipment" => equipment_params}) do
    case FixedCosts.create_equipment(equipment_params) do
      {:ok, equipment} ->
        conn
        |> put_flash(:info, "Equipment created successfully.")
        |> redirect(to: equipment_path(conn, :show, equipment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    equipment = FixedCosts.get_equipment!(id)
    render(conn, "show.html", equipment: equipment)
  end

  def edit(conn, %{"id" => id}) do
    equipment = FixedCosts.get_equipment!(id)
    changeset = FixedCosts.change_equipment(equipment)
    render(conn, "edit.html", equipment: equipment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "equipment" => equipment_params}) do
    equipment = FixedCosts.get_equipment!(id)

    case FixedCosts.update_equipment(equipment, equipment_params) do
      {:ok, equipment} ->
        conn
        |> put_flash(:info, "Equipment updated successfully.")
        |> redirect(to: equipment_path(conn, :show, equipment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", equipment: equipment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    equipment = FixedCosts.get_equipment!(id)
    {:ok, _equipment} = FixedCosts.delete_equipment(equipment)

    conn
    |> put_flash(:info, "Equipment deleted successfully.")
    |> redirect(to: equipment_path(conn, :index))
  end
end
