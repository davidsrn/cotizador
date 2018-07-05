defmodule CotizadorWeb.GrowthAndCultureControllerTest do
  use CotizadorWeb.ConnCase

  alias Cotizador.FixedCosts

  @create_attrs %{date: ~D[2010-04-17], detail: "some detail", name: "some name", yearly_cost: "some yearly_cost"}
  @update_attrs %{date: ~D[2011-05-18], detail: "some updated detail", name: "some updated name", yearly_cost: "some updated yearly_cost"}
  @invalid_attrs %{date: nil, detail: nil, name: nil, yearly_cost: nil}

  def fixture(:growth_and_culture) do
    {:ok, growth_and_culture} = FixedCosts.create_growth_and_culture(@create_attrs)
    growth_and_culture
  end

  describe "index" do
    test "lists all growth_and_culture_item", %{conn: conn} do
      conn = get conn, growth_and_culture_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Growth and culture item"
    end
  end

  describe "new growth_and_culture" do
    test "renders form", %{conn: conn} do
      conn = get conn, growth_and_culture_path(conn, :new)
      assert html_response(conn, 200) =~ "New Growth and culture"
    end
  end

  describe "create growth_and_culture" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, growth_and_culture_path(conn, :create), growth_and_culture: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == growth_and_culture_path(conn, :show, id)

      conn = get conn, growth_and_culture_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Growth and culture"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, growth_and_culture_path(conn, :create), growth_and_culture: @invalid_attrs
      assert html_response(conn, 200) =~ "New Growth and culture"
    end
  end

  describe "edit growth_and_culture" do
    setup [:create_growth_and_culture]

    test "renders form for editing chosen growth_and_culture", %{conn: conn, growth_and_culture: growth_and_culture} do
      conn = get conn, growth_and_culture_path(conn, :edit, growth_and_culture)
      assert html_response(conn, 200) =~ "Edit Growth and culture"
    end
  end

  describe "update growth_and_culture" do
    setup [:create_growth_and_culture]

    test "redirects when data is valid", %{conn: conn, growth_and_culture: growth_and_culture} do
      conn = put conn, growth_and_culture_path(conn, :update, growth_and_culture), growth_and_culture: @update_attrs
      assert redirected_to(conn) == growth_and_culture_path(conn, :show, growth_and_culture)

      conn = get conn, growth_and_culture_path(conn, :show, growth_and_culture)
      assert html_response(conn, 200) =~ "some updated detail"
    end

    test "renders errors when data is invalid", %{conn: conn, growth_and_culture: growth_and_culture} do
      conn = put conn, growth_and_culture_path(conn, :update, growth_and_culture), growth_and_culture: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Growth and culture"
    end
  end

  describe "delete growth_and_culture" do
    setup [:create_growth_and_culture]

    test "deletes chosen growth_and_culture", %{conn: conn, growth_and_culture: growth_and_culture} do
      conn = delete conn, growth_and_culture_path(conn, :delete, growth_and_culture)
      assert redirected_to(conn) == growth_and_culture_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, growth_and_culture_path(conn, :show, growth_and_culture)
      end
    end
  end

  defp create_growth_and_culture(_) do
    growth_and_culture = fixture(:growth_and_culture)
    {:ok, growth_and_culture: growth_and_culture}
  end
end
