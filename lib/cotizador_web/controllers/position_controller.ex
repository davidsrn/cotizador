defmodule CotizadorWeb.PositionController do
  use CotizadorWeb, :controller

  alias Cotizador.HumanResources
  alias Cotizador.HumanResources.Position
  alias Cotizador.Repo
  import Ecto.Query, warn: false
  alias Cotizador.Locations.Location

  def index(conn, _params) do
    positions = HumanResources.list_positions()
    render(conn, "index.html", positions: positions)
  end

  def new(conn, _params) do
    changeset = HumanResources.change_position(%Position{})
    query = from loc in Location,
            select: {loc.name, loc.id}
    location_select = Repo.all(query)
    render(conn, "new.html", changeset: changeset, locations: location_select)
  end

  def create(conn, %{"position" => position_params}) do
    case HumanResources.create_position(position_params) do
      {:ok, position} ->
        conn
        |> put_flash(:info, "Position created successfully.")
        |> redirect(to: position_path(conn, :show, position))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    position = HumanResources.get_position!(id)
    render(conn, "show.html", position: position)
  end

  def edit(conn, %{"id" => id}) do
    position = HumanResources.get_position!(id)
    changeset = HumanResources.change_position(position)
    render(conn, "edit.html", position: position, changeset: changeset)
  end

  def update(conn, %{"id" => id, "position" => position_params}) do
    position = HumanResources.get_position!(id)

    case HumanResources.update_position(position, position_params) do
      {:ok, position} ->
        conn
        |> put_flash(:info, "Position updated successfully.")
        |> redirect(to: position_path(conn, :show, position))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", position: position, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    position = HumanResources.get_position!(id)
    {:ok, _position} = HumanResources.delete_position(position)

    conn
    |> put_flash(:info, "Position deleted successfully.")
    |> redirect(to: position_path(conn, :index))
  end
end
