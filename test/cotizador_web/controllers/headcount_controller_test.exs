defmodule CotizadorWeb.HeadcountControllerTest do
  use CotizadorWeb.ConnCase

  alias Cotizador.HumanResources

  @create_attrs %{name: "some name", salary: 120.5}
  @update_attrs %{name: "some updated name", salary: 456.7}
  @invalid_attrs %{name: nil, salary: nil}

  def fixture(:headcount) do
    {:ok, headcount} = HumanResources.create_headcount(@create_attrs)
    headcount
  end

  describe "index" do
    test "lists all persons", %{conn: conn} do
      conn = get conn, headcount_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Persons"
    end
  end

  describe "new headcount" do
    test "renders form", %{conn: conn} do
      conn = get conn, headcount_path(conn, :new)
      assert html_response(conn, 200) =~ "New Headcount"
    end
  end

  describe "create headcount" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, headcount_path(conn, :create), headcount: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == headcount_path(conn, :show, id)

      conn = get conn, headcount_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Headcount"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, headcount_path(conn, :create), headcount: @invalid_attrs
      assert html_response(conn, 200) =~ "New Headcount"
    end
  end

  describe "edit headcount" do
    setup [:create_headcount]

    test "renders form for editing chosen headcount", %{conn: conn, headcount: headcount} do
      conn = get conn, headcount_path(conn, :edit, headcount)
      assert html_response(conn, 200) =~ "Edit Headcount"
    end
  end

  describe "update headcount" do
    setup [:create_headcount]

    test "redirects when data is valid", %{conn: conn, headcount: headcount} do
      conn = put conn, headcount_path(conn, :update, headcount), headcount: @update_attrs
      assert redirected_to(conn) == headcount_path(conn, :show, headcount)

      conn = get conn, headcount_path(conn, :show, headcount)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, headcount: headcount} do
      conn = put conn, headcount_path(conn, :update, headcount), headcount: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Headcount"
    end
  end

  describe "delete headcount" do
    setup [:create_headcount]

    test "deletes chosen headcount", %{conn: conn, headcount: headcount} do
      conn = delete conn, headcount_path(conn, :delete, headcount)
      assert redirected_to(conn) == headcount_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, headcount_path(conn, :show, headcount)
      end
    end
  end

  defp create_headcount(_) do
    headcount = fixture(:headcount)
    {:ok, headcount: headcount}
  end
end
