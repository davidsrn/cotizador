defmodule CotizadorWeb.CalculatorController do
  use CotizadorWeb, :controller

  alias Cotizador.Calculator

  def index(conn, _params) do
    render(conn, "index.html", expenses: Calculator.sum_expenses())
  end

  def new(conn, _params) do
    positions =
      Cotizador.HumanResources.get_position_avg

    render(conn, "new.html", positions: positions)
  end

  def create(conn, %{"data" => data}) do
    # Calculator.calc_total_cost(data)
    IO.inspect data
    render(conn, "index.html")
  end

end
