defmodule CotizadorWeb.FranchiseFeeControllerTest do
  use CotizadorWeb.ConnCase

  alias Cotizador.FixedCosts

  @create_attrs %{name: "some name", value: "some value"}
  @update_attrs %{name: "some updated name", value: "some updated value"}
  @invalid_attrs %{name: nil, value: nil}

  def fixture(:franchise_fee) do
    {:ok, franchise_fee} = FixedCosts.create_franchise_fee(@create_attrs)
    franchise_fee
  end

  describe "index" do
    test "lists all franchise_fees", %{conn: conn} do
      conn = get conn, franchise_fee_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Franchise fees"
    end
  end

  describe "new franchise_fee" do
    test "renders form", %{conn: conn} do
      conn = get conn, franchise_fee_path(conn, :new)
      assert html_response(conn, 200) =~ "New Franchise fee"
    end
  end

  describe "create franchise_fee" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, franchise_fee_path(conn, :create), franchise_fee: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == franchise_fee_path(conn, :show, id)

      conn = get conn, franchise_fee_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Franchise fee"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, franchise_fee_path(conn, :create), franchise_fee: @invalid_attrs
      assert html_response(conn, 200) =~ "New Franchise fee"
    end
  end

  describe "edit franchise_fee" do
    setup [:create_franchise_fee]

    test "renders form for editing chosen franchise_fee", %{conn: conn, franchise_fee: franchise_fee} do
      conn = get conn, franchise_fee_path(conn, :edit, franchise_fee)
      assert html_response(conn, 200) =~ "Edit Franchise fee"
    end
  end

  describe "update franchise_fee" do
    setup [:create_franchise_fee]

    test "redirects when data is valid", %{conn: conn, franchise_fee: franchise_fee} do
      conn = put conn, franchise_fee_path(conn, :update, franchise_fee), franchise_fee: @update_attrs
      assert redirected_to(conn) == franchise_fee_path(conn, :show, franchise_fee)

      conn = get conn, franchise_fee_path(conn, :show, franchise_fee)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, franchise_fee: franchise_fee} do
      conn = put conn, franchise_fee_path(conn, :update, franchise_fee), franchise_fee: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Franchise fee"
    end
  end

  describe "delete franchise_fee" do
    setup [:create_franchise_fee]

    test "deletes chosen franchise_fee", %{conn: conn, franchise_fee: franchise_fee} do
      conn = delete conn, franchise_fee_path(conn, :delete, franchise_fee)
      assert redirected_to(conn) == franchise_fee_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, franchise_fee_path(conn, :show, franchise_fee)
      end
    end
  end

  defp create_franchise_fee(_) do
    franchise_fee = fixture(:franchise_fee)
    {:ok, franchise_fee: franchise_fee}
  end
end
