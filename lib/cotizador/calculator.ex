defmodule Cotizador.Calculator do

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
        el/12
      end
    Enum.sum(values)
  end


  def sum_expenses do
    this_month = Date.utc_today.month
    no_employees = Repo.one(from p in Headcount, select: count(p.id))
    rate = Repo.one(from r in ExangeRate,
                    where: fragment("Extract(month from ?)", r.date) == ^this_month,
                    select: r.amount)
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

    total =
      sum_monthly_query_results(Repo.all(op_query)) +
      sum_yearly_query_results(Repo.all(g_and_c_query)) +
      sum_monthly_query_results(Repo.all(headcount_query)) +
      (sum_monthly_query_results(Repo.all(headcount_query)) - 100) * 0.07 +
      1350 * no_employees + 200 * no_employees +
      rate * no_employees * sum_monthly_query_results(Repo.all(franchise_fee_query))

    total

  end

  def calc_man_hours(variable_cost_list) do
    man_hour_list =
      for {_, hours} <- variable_cost_list do
        hours
      end
    Enum.sum(man_hour_list)
  end

  def total_man_hours do
    Repo.one(from p in Headcount, select: count(p.id)) * 17 * 8
  end

  def calc_contribution(variable_cost_list) do
    # Enum.sum(man_hour_list) / (Repo.one(from p in Headcount, select: count(p.id)) * 17 * 8)
    # IO.puts "----------------"
    # IO.puts "Contribution #{calc_man_hours(variable_cost_list) / total_man_hours()}"
    # IO.puts "----------------"
    calc_man_hours(variable_cost_list) / total_man_hours()
  end

  def calc_fixed_costs(variable_cost_list) do
    sum_expenses() * calc_contribution(variable_cost_list)
  end

  def calc_flat_cost(flat_cost_list) do
    case flat_cost_list do
      nil -> 0
      _ -> Enum.sum(flat_cost_list)
    end
  end

  def calc_variable_cost(variable_cost_list) do
    total =
      for resource <- variable_cost_list do
        {id, hours} = resource
        hours * (Repo.one(from p in Headcount,
                          where: p.id == ^id,
                          select: p.salary) / 17 / 8)
      end
    Enum.sum total
  end

  def calc_total_cost_and_create_project(variable_cost_list, flat_cost_list, margin, name) do

    rate = Repo.one(from r in ExangeRate,
                    where: fragment("Extract(month from ?)", r.date) == ^Date.utc_today.month,
                    select: r.amount)
    flat_cost = calc_flat_cost(flat_cost_list)
    fixed_cost = calc_fixed_costs(variable_cost_list)
    variable_cost = calc_variable_cost(variable_cost_list)
    total_cost = flat_cost + fixed_cost + variable_cost
    Cotizador.Projects.create_project(%{
                                        name: name,
                                        flat_mxn: flat_cost,
                                        fixed_mxn: fixed_cost,
                                        variable_mxn: variable_cost,
                                        total_mxn: total_cost,
                                        total_margin_mxn: total_cost / (1-margin),
                                        flat_usd: flat_cost / rate,
                                        fixed_usd: fixed_cost / rate,
                                        variable_usd: variable_cost / rate,
                                        total_usd: total_cost / rate,
                                        total_margin_usd: (total_cost / (1-margin)) / rate,
                                      })
  end

  def calc_total_cost(variable_cost_list, flat_cost_list, margin, name) do

    rate = Repo.one(from r in ExangeRate,
                    where: fragment("Extract(month from ?)", r.date) == ^Date.utc_today.month,
                    select: r.amount)
    flat_cost = calc_flat_cost(flat_cost_list)
    fixed_cost = calc_fixed_costs(variable_cost_list)
    variable_cost = calc_variable_cost(variable_cost_list)
    total_cost = flat_cost + fixed_cost + variable_cost
    IO.puts "--------------------------------"
    IO.puts name
    IO.puts "--------------------------------"
    IO.puts ("Price in MXN:")
    IO.puts ("Flat cost: #{flat_cost}")
    IO.puts ("Fixed cost: #{fixed_cost}")
    IO.puts ("Variable cost: #{variable_cost}")
    IO.puts ("Total cost: #{total_cost}")
    IO.puts ("Price with margin: #{total_cost / (1-margin)}")
    IO.puts "--------------------------------"
    IO.puts ("Price in USD:")
    IO.puts ("Flat cost: #{flat_cost / rate}")
    IO.puts ("Fixed cost: #{fixed_cost / rate}")
    IO.puts ("Variable cost: #{variable_cost / rate}")
    IO.puts ("Total cost: #{total_cost / rate}")
    IO.puts ("Price with margin: #{(total_cost / (1-margin))/ rate}")
    IO.puts "--------------------------------"
  end


end
