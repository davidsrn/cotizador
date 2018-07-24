defmodule Cotizador.Calculator do
  @moduledoc """
  The calculator that calculates EVERYTHING.
  """

  use Timex

  import Ecto.Query, warn: false
  alias Cotizador.Repo

  alias Cotizador.FixedCosts.Operation
  alias Cotizador.FixedCosts.GrowthAndCulture
  alias Cotizador.FixedCosts.ExangeRate
  alias Cotizador.FixedCosts.FranchiseFee
  alias Cotizador.FixedCosts.Equipment
  alias Cotizador.HumanResources
  alias Cotizador.HumanResources.Headcount

  @doc """
  Returns the sum of a list of items that are measured by month.

  Recieves a list of numbers and returns it's sum

  ## Examples

      iex> sum_monthly_query_results([1, 2, 3])
      6

  """

  def sum_monthly_query_results(list) do
    Enum.sum(list)
  end

  @doc """
  Returns the sum of a list of items that are measured yearly.

  Recieves a list of numbers and returns it's sum divided by 12

  ## Examples

      iex> sum_yearly_query_results([1, 2, 3])
      0.5

  """

  def sum_yearly_query_results(list) do
    Enum.sum(list) / 12
  end

  @doc """
  Returns the sum of the cost of depreciation of the registered items

  Recieves a list of items and returns the sum of the cost of depreciation

  ## Examples

      iex> sum_equipment_expenses([%{cost: 21750.0, final_date: ~D[2019-01-01], initial_date: ~D[2018-01-01]}])
      9062.5

  """

  def sum_equipment_expenses(list) do
    values =
      for eq <- list do
        if Date.compare(eq.initial_date, Date.utc_today) == :gt do
          0
        else
          (eq.cost / Timex.diff(eq.final_date, eq.initial_date, :months)) *
          Timex.diff(eq.final_date, Date.utc_today, :months)
        end
      end
    Enum.sum(values)
  end

  @doc """
  Returns the sum of all the expences that are calculated depending of the abailable resources

  ## Examples

      iex> sum_expenses
      73290.0

  """

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
    items_query =
      from eq in Equipment,
      where: (fragment("Extract(month from ?)", eq.final_date) >= ^Date.utc_today.month and
      fragment("Extract(year from ?)", eq.final_date) == ^Date.utc_today.year) or
      fragment("Extract(year from ?)", eq.final_date) >= ^Date.utc_today.year,
      select: %{cost: eq.cost, initial_date: eq.initial_date, final_date: eq.final_date}


    total =
      sum_monthly_query_results(Repo.all(op_query)) +
      sum_yearly_query_results(Repo.all(g_and_c_query)) +
      sum_monthly_query_results(Repo.all(headcount_query)) +
      sum_equipment_expenses(Repo.all(items_query)) +
      (sum_monthly_query_results(Repo.all(headcount_query)) - 100) * 0.07 +
      1350 * no_employees + 200 * no_employees +
      rate * no_employees * sum_monthly_query_results(Repo.all(franchise_fee_query))

    total

  end

  @doc """
  Returns the sum of all the man hours recieved

  Recieves a list of tuples with the structure: {position_id, hours}

  ## Examples

      iex> calc_man_hours([{1, 2}, {2, 3}])
      5

  """

  def calc_man_hours(variable_cost_list) do
    man_hour_list =
      for {_, hours} <- variable_cost_list do
        hours
      end
    Enum.sum(man_hour_list)
  end

  @doc """
  Returns the all of the abailable man hours based on the registered users


  ## Examples

      iex> total_man_hours
      408

  """

  def total_man_hours do
    Repo.one(from p in Headcount, select: count(p.id)) * 17 * 8
  end

  @doc """
  Returns calculated contribution based on the recieved man hours and the total amount
    of hours availabe


  ## Examples

      iex> calc_contribution([{1, 200}, {2, 300}])
      1.2254901960784315

  """

  def calc_contribution(variable_cost_list) do
    calc_man_hours(variable_cost_list) / total_man_hours()
  end

  @doc """
  Returns calculated contribution based on the recieved man hours and the total amount
    of hours availabe


  ## Examples

      iex> calc_contribution([{1, 200}, {2, 300}])
      1.2254901960784315

  """

  def calc_fixed_costs(variable_cost_list) do
    sum_expenses() * calc_contribution(variable_cost_list)
  end

  @doc """
  Returns the sum of the recieved flat costs


  ## Examples

      iex> calc_flat_cost([1,2])
      3

  """

  def calc_flat_cost(flat_cost_list) do
    case flat_cost_list do
      [] -> 0
      _ -> Enum.sum(flat_cost_list)
    end
  end

  @doc """
  Returns the sum of the variable costs depending on the average salary of the positions

  Recieves a list of tuples with the structure: {position_id, hours}

  ## Examples

      iex> calc_variable_cost([{1, 200}, {2, 300}])
      551.4705882352941

  """

  def calc_variable_cost(variable_cost_list) do
    total =
      for resource <- variable_cost_list do
        {id, hours} = resource
        hours * HumanResources.get_position_avg(id) / (17 * 8)
      end
    Enum.sum total
  end

  @doc """
  Creates a Project with the information recieved

  """

  def calc_total_cost_and_create_project(variable_cost_list, flat_cost_list \\ nil, margin, name) do
    rate =
      Repo.one(
        from r in ExangeRate,
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

  @doc """
  Prints the cost of a project with the recieved information


  """

  def calc_total_cost(variable_cost_list, flat_cost_list \\ nil, margin, name) do
    rate =
      Repo.one(
        from r in ExangeRate,
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
