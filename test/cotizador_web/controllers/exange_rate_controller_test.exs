defmodule CotizadorWeb.ExangeRateControllerTest do
  use CotizadorWeb.ConnCase

  alias Cotizador.FixedCosts

  @create_attrs %{amout: "some amout", date: ~D[2010-04-17]}
  @update_attrs %{amout: "some updated amout", date: ~D[2011-05-18]}
  @invalid_attrs %{amout: nil, date: nil}

  def fixture(:exange_rate) do
    {:ok, exange_rate} = FixedCosts.create_exange_rate(@create_attrs)
    exange_rate
  end

  describe "index" do
    test "lists all rates", %{conn: conn} do
      conn = get conn, exange_rate_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Rates"
    end
  end

  describe "new exange_rate" do
    test "renders form", %{conn: conn} do
      conn = get conn, exange_rate_path(conn, :new)
      assert html_response(conn, 200) =~ "New Exange rate"
    end
  end

  describe "create exange_rate" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, exange_rate_path(conn, :create), exange_rate: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == exange_rate_path(conn, :show, id)

      conn = get conn, exange_rate_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Exange rate"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, exange_rate_path(conn, :create), exange_rate: @invalid_attrs
      assert html_response(conn, 200) =~ "New Exange rate"
    end
  end

  describe "edit exange_rate" do
    setup [:create_exange_rate]

    test "renders form for editing chosen exange_rate", %{conn: conn, exange_rate: exange_rate} do
      conn = get conn, exange_rate_path(conn, :edit, exange_rate)
      assert html_response(conn, 200) =~ "Edit Exange rate"
    end
  end

  describe "update exange_rate" do
    setup [:create_exange_rate]

    test "redirects when data is valid", %{conn: conn, exange_rate: exange_rate} do
      conn = put conn, exange_rate_path(conn, :update, exange_rate), exange_rate: @update_attrs
      assert redirected_to(conn) == exange_rate_path(conn, :show, exange_rate)

      conn = get conn, exange_rate_path(conn, :show, exange_rate)
      assert html_response(conn, 200) =~ "some updated amout"
    end

    test "renders errors when data is invalid", %{conn: conn, exange_rate: exange_rate} do
      conn = put conn, exange_rate_path(conn, :update, exange_rate), exange_rate: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Exange rate"
    end
  end

  describe "delete exange_rate" do
    setup [:create_exange_rate]

    test "deletes chosen exange_rate", %{conn: conn, exange_rate: exange_rate} do
      conn = delete conn, exange_rate_path(conn, :delete, exange_rate)
      assert redirected_to(conn) == exange_rate_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, exange_rate_path(conn, :show, exange_rate)
      end
    end
  end

  defp create_exange_rate(_) do
    exange_rate = fixture(:exange_rate)
    {:ok, exange_rate: exange_rate}
  end
end
