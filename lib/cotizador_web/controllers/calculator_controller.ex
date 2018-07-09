defmodule CotizadorWeb.CalculatorController do
  use CotizadorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
