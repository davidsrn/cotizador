defmodule CotizadorWeb.HeadcountController do
  use CotizadorWeb, :controller

  alias Cotizador.HumanResources
  alias Cotizador.HumanResources.Headcount

  def index(conn, _params) do
    persons = HumanResources.list_persons()
    render(conn, "index.html", persons: persons)
  end

  def new(conn, _params) do
    changeset = HumanResources.change_headcount(%Headcount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"headcount" => headcount_params}) do
    case HumanResources.create_headcount(headcount_params) do
      {:ok, headcount} ->
        conn
        |> put_flash(:info, "Headcount created successfully.")
        |> redirect(to: headcount_path(conn, :show, headcount))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    headcount = HumanResources.get_headcount!(id)
    render(conn, "show.html", headcount: headcount)
  end

  def edit(conn, %{"id" => id}) do
    headcount = HumanResources.get_headcount!(id)
    changeset = HumanResources.change_headcount(headcount)
    render(conn, "edit.html", headcount: headcount, changeset: changeset)
  end

  def update(conn, %{"id" => id, "headcount" => headcount_params}) do
    headcount = HumanResources.get_headcount!(id)

    case HumanResources.update_headcount(headcount, headcount_params) do
      {:ok, headcount} ->
        conn
        |> put_flash(:info, "Headcount updated successfully.")
        |> redirect(to: headcount_path(conn, :show, headcount))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", headcount: headcount, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    headcount = HumanResources.get_headcount!(id)
    {:ok, _headcount} = HumanResources.delete_headcount(headcount)

    conn
    |> put_flash(:info, "Headcount deleted successfully.")
    |> redirect(to: headcount_path(conn, :index))
  end
end
