defmodule CotizadorWeb.OperationController do
  use CotizadorWeb, :controller

  alias Cotizador.FixedCosts
  alias Cotizador.FixedCosts.Operation

  def index(conn, _params) do
    operations = FixedCosts.list_operations()
    render(conn, "index.html", operations: operations)
  end

  def new(conn, _params) do
    changeset = FixedCosts.change_operation(%Operation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"operation" => operation_params}) do
    case FixedCosts.create_operation(operation_params) do
      {:ok, operation} ->
        conn
        |> put_flash(:info, "Operation created successfully.")
        |> redirect(to: operation_path(conn, :show, operation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    operation = FixedCosts.get_operation!(id)
    render(conn, "show.html", operation: operation)
  end

  def edit(conn, %{"id" => id}) do
    operation = FixedCosts.get_operation!(id)
    changeset = FixedCosts.change_operation(operation)
    render(conn, "edit.html", operation: operation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "operation" => operation_params}) do
    operation = FixedCosts.get_operation!(id)

    case FixedCosts.update_operation(operation, operation_params) do
      {:ok, operation} ->
        conn
        |> put_flash(:info, "Operation updated successfully.")
        |> redirect(to: operation_path(conn, :show, operation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", operation: operation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    operation = FixedCosts.get_operation!(id)
    {:ok, _operation} = FixedCosts.delete_operation(operation)

    conn
    |> put_flash(:info, "Operation deleted successfully.")
    |> redirect(to: operation_path(conn, :index))
  end
end
