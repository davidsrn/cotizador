defmodule CotizadorWeb.GrowthAndCultureController do
  use CotizadorWeb, :controller

  alias Cotizador.FixedCosts
  alias Cotizador.FixedCosts.GrowthAndCulture

  def index(conn, _params) do
    growth_and_culture_item = FixedCosts.list_growth_and_culture_item()
    render(conn, "index.html", growth_and_culture_item: growth_and_culture_item)
  end

  def new(conn, _params) do
    changeset = FixedCosts.change_growth_and_culture(%GrowthAndCulture{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"growth_and_culture" => growth_and_culture_params}) do
    case FixedCosts.create_growth_and_culture(growth_and_culture_params) do
      {:ok, growth_and_culture} ->
        conn
        |> put_flash(:info, "Growth and culture created successfully.")
        |> redirect(to: growth_and_culture_path(conn, :show, growth_and_culture))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    growth_and_culture = FixedCosts.get_growth_and_culture!(id)
    render(conn, "show.html", growth_and_culture: growth_and_culture)
  end

  def edit(conn, %{"id" => id}) do
    growth_and_culture = FixedCosts.get_growth_and_culture!(id)
    changeset = FixedCosts.change_growth_and_culture(growth_and_culture)
    render(conn, "edit.html", growth_and_culture: growth_and_culture, changeset: changeset)
  end

  def update(conn, %{"id" => id, "growth_and_culture" => growth_and_culture_params}) do
    growth_and_culture = FixedCosts.get_growth_and_culture!(id)

    case FixedCosts.update_growth_and_culture(growth_and_culture, growth_and_culture_params) do
      {:ok, growth_and_culture} ->
        conn
        |> put_flash(:info, "Growth and culture updated successfully.")
        |> redirect(to: growth_and_culture_path(conn, :show, growth_and_culture))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", growth_and_culture: growth_and_culture, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    growth_and_culture = FixedCosts.get_growth_and_culture!(id)
    {:ok, _growth_and_culture} = FixedCosts.delete_growth_and_culture(growth_and_culture)

    conn
    |> put_flash(:info, "Growth and culture deleted successfully.")
    |> redirect(to: growth_and_culture_path(conn, :index))
  end
end
