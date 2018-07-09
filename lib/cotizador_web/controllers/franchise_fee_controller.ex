defmodule CotizadorWeb.FranchiseFeeController do
  use CotizadorWeb, :controller

  alias Cotizador.FixedCosts
  alias Cotizador.FixedCosts.FranchiseFee
  alias Cotizador.Repo
  import Ecto.Query, warn: false
  alias Cotizador.Locations.Location

  def index(conn, _params) do
    franchise_fees = FixedCosts.list_franchise_fees()
    render(conn, "index.html", franchise_fees: franchise_fees)
  end

  def new(conn, _params) do
    changeset = FixedCosts.change_franchise_fee(%FranchiseFee{})
    query = from loc in Location,
            select: {loc.name, loc.id}
    location_select = Repo.all(query)
    render(conn, "new.html", changeset: changeset, locations: location_select)
  end

  def create(conn, %{"franchise_fee" => franchise_fee_params}) do
    case FixedCosts.create_franchise_fee(franchise_fee_params) do
      {:ok, franchise_fee} ->
        conn
        |> put_flash(:info, "Franchise fee created successfully.")
        |> redirect(to: franchise_fee_path(conn, :show, franchise_fee))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    franchise_fee = FixedCosts.get_franchise_fee!(id)
    render(conn, "show.html", franchise_fee: franchise_fee)
  end

  def edit(conn, %{"id" => id}) do
    franchise_fee = FixedCosts.get_franchise_fee!(id)
    changeset = FixedCosts.change_franchise_fee(franchise_fee)
    render(conn, "edit.html", franchise_fee: franchise_fee, changeset: changeset)
  end

  def update(conn, %{"id" => id, "franchise_fee" => franchise_fee_params}) do
    franchise_fee = FixedCosts.get_franchise_fee!(id)

    case FixedCosts.update_franchise_fee(franchise_fee, franchise_fee_params) do
      {:ok, franchise_fee} ->
        conn
        |> put_flash(:info, "Franchise fee updated successfully.")
        |> redirect(to: franchise_fee_path(conn, :show, franchise_fee))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", franchise_fee: franchise_fee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    franchise_fee = FixedCosts.get_franchise_fee!(id)
    {:ok, _franchise_fee} = FixedCosts.delete_franchise_fee(franchise_fee)

    conn
    |> put_flash(:info, "Franchise fee deleted successfully.")
    |> redirect(to: franchise_fee_path(conn, :index))
  end
end
