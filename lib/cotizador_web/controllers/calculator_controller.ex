defmodule CotizadorWeb.CalculatorController do
  use CotizadorWeb, :controller

  alias Cotizador.Calculator

  def index(conn, _params) do
    render(conn, "index.html", expenses: Calculator.sum_expenses())
  end

end
