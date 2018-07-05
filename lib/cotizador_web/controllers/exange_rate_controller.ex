defmodule CotizadorWeb.ExangeRateController do
  use CotizadorWeb, :controller

  alias Cotizador.FixedCosts
  alias Cotizador.FixedCosts.ExangeRate

  def index(conn, _params) do
    rates = FixedCosts.list_rates()
    render(conn, "index.html", rates: rates)
  end

  def new(conn, _params) do
    changeset = FixedCosts.change_exange_rate(%ExangeRate{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"exange_rate" => exange_rate_params}) do
    case FixedCosts.create_exange_rate(exange_rate_params) do
      {:ok, exange_rate} ->
        conn
        |> put_flash(:info, "Exange rate created successfully.")
        |> redirect(to: exange_rate_path(conn, :show, exange_rate))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    exange_rate = FixedCosts.get_exange_rate!(id)
    render(conn, "show.html", exange_rate: exange_rate)
  end

  def edit(conn, %{"id" => id}) do
    exange_rate = FixedCosts.get_exange_rate!(id)
    changeset = FixedCosts.change_exange_rate(exange_rate)
    render(conn, "edit.html", exange_rate: exange_rate, changeset: changeset)
  end

  def update(conn, %{"id" => id, "exange_rate" => exange_rate_params}) do
    exange_rate = FixedCosts.get_exange_rate!(id)

    case FixedCosts.update_exange_rate(exange_rate, exange_rate_params) do
      {:ok, exange_rate} ->
        conn
        |> put_flash(:info, "Exange rate updated successfully.")
        |> redirect(to: exange_rate_path(conn, :show, exange_rate))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", exange_rate: exange_rate, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    exange_rate = FixedCosts.get_exange_rate!(id)
    {:ok, _exange_rate} = FixedCosts.delete_exange_rate(exange_rate)

    conn
    |> put_flash(:info, "Exange rate deleted successfully.")
    |> redirect(to: exange_rate_path(conn, :index))
  end
end
