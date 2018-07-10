defmodule CotizadorWeb.CalculatorController do
  use CotizadorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  import Ecto.Query, warn: false
  alias Cotizador.Repo

  alias Cotizador.FixedCosts.Operation
  alias Cotizador.FixedCosts.GrowthAndCulture
  alias Cotizador.FixedCosts.ExangeRate
  alias Cotizador.FixedCosts.FranchiseFee
  alias Cotizador.HumanResources.Headcount

  def sum_monthly_query_results(list) do
    values =
      for el <- list do
        el
      end
    Enum.sum(values)
  end

  def sum_yearly_query_results(list) do

    values =
      for el <- list do
        IO.inspect el/12
        el/12
      end
    Enum.sum(values)
  end


  def sum_expenses do
    this_month = Date.utc_today.month
    no_employees = Repo.one(from p in Headcount, select: count(p.id))
    rate = Repo.one(from r in ExangeRate, where: fragment("Extract(month from ?)", r.date) == ^this_month, select: r.amount)
    op_query =
      from op in Operation,
      where: fragment("Extract(month from ?)", op.date) == ^this_month,
      # group_by: op.date,
      select: op.monthly_cost
    g_and_c_query =
      from gc in GrowthAndCulture,
      where: fragment("Extract(month from ?)", gc.date) == ^this_month,
      # group_by: op.date,
      select: gc.yearly_cost
    headcount_query =
      from p in Headcount,
      select: p.salary
    franchise_fee_query =
        from ff in FranchiseFee,
        select: ff.value

    total = sum_monthly_query_results(Repo.all(op_query)) +
            sum_yearly_query_results(Repo.all(g_and_c_query)) +
            sum_monthly_query_results(Repo.all(headcount_query)) +
            (sum_monthly_query_results(Repo.all(headcount_query)) - 100) * 0.07 +
            1350 * no_employees + 200 * no_employees +
            rate * no_employees * sum_monthly_query_results(Repo.all(franchise_fee_query))

    total

  end


end
