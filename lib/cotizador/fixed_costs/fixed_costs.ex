defmodule Cotizador.FixedCosts do
  @moduledoc """
  The FixedCosts context.
  """

  import Ecto.Query, warn: false
  alias Cotizador.Repo

  alias Cotizador.FixedCosts.Operation

  @doc """
  Returns the list of operations.

  ## Examples

      iex> list_operations()
      [%Operation{}, ...]

  """
  def list_operations do
    Repo.all(Operation)
  end

  @doc """
  Gets a single operation.

  Raises `Ecto.NoResultsError` if the Operation does not exist.

  ## Examples

      iex> get_operation!(123)
      %Operation{}

      iex> get_operation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operation!(id), do: Repo.get!(Operation, id)

  @doc """
  Creates a operation.

  ## Examples

      iex> create_operation(%{field: value})
      {:ok, %Operation{}}

      iex> create_operation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_operation(attrs \\ %{}) do
    %Operation{}
    |> Operation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a operation.

  ## Examples

      iex> update_operation(operation, %{field: new_value})
      {:ok, %Operation{}}

      iex> update_operation(operation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operation(%Operation{} = operation, attrs) do
    operation
    |> Operation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Operation.

  ## Examples

      iex> delete_operation(operation)
      {:ok, %Operation{}}

      iex> delete_operation(operation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operation(%Operation{} = operation) do
    Repo.delete(operation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operation changes.

  ## Examples

      iex> change_operation(operation)
      %Ecto.Changeset{source: %Operation{}}

  """
  def change_operation(%Operation{} = operation) do
    Operation.changeset(operation, %{})
  end

  alias Cotizador.FixedCosts.Equipment

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Equipment{}, ...]

  """
  def list_items do
    Repo.all(Equipment)
  end

  @doc """
  Gets a single equipment.

  Raises `Ecto.NoResultsError` if the Equipment does not exist.

  ## Examples

      iex> get_equipment!(123)
      %Equipment{}

      iex> get_equipment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_equipment!(id), do: Repo.get!(Equipment, id)

  @doc """
  Creates a equipment.

  ## Examples

      iex> create_equipment(%{field: value})
      {:ok, %Equipment{}}

      iex> create_equipment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_equipment(attrs \\ %{}) do
    %Equipment{}
    |> Equipment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a equipment.

  ## Examples

      iex> update_equipment(equipment, %{field: new_value})
      {:ok, %Equipment{}}

      iex> update_equipment(equipment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_equipment(%Equipment{} = equipment, attrs) do
    equipment
    |> Equipment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Equipment.

  ## Examples

      iex> delete_equipment(equipment)
      {:ok, %Equipment{}}

      iex> delete_equipment(equipment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_equipment(%Equipment{} = equipment) do
    Repo.delete(equipment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking equipment changes.

  ## Examples

      iex> change_equipment(equipment)
      %Ecto.Changeset{source: %Equipment{}}

  """
  def change_equipment(%Equipment{} = equipment) do
    Equipment.changeset(equipment, %{})
  end

  alias Cotizador.FixedCosts.GrowthAndCulture

  @doc """
  Returns the list of growth_and_culture_item.

  ## Examples

      iex> list_growth_and_culture_item()
      [%GrowthAndCulture{}, ...]

  """
  def list_growth_and_culture_item do
    Repo.all(GrowthAndCulture)
  end

  @doc """
  Gets a single growth_and_culture.

  Raises `Ecto.NoResultsError` if the Growth and culture does not exist.

  ## Examples

      iex> get_growth_and_culture!(123)
      %GrowthAndCulture{}

      iex> get_growth_and_culture!(456)
      ** (Ecto.NoResultsError)

  """
  def get_growth_and_culture!(id), do: Repo.get!(GrowthAndCulture, id)

  @doc """
  Creates a growth_and_culture.

  ## Examples

      iex> create_growth_and_culture(%{field: value})
      {:ok, %GrowthAndCulture{}}

      iex> create_growth_and_culture(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_growth_and_culture(attrs \\ %{}) do
    %GrowthAndCulture{}
    |> GrowthAndCulture.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a growth_and_culture.

  ## Examples

      iex> update_growth_and_culture(growth_and_culture, %{field: new_value})
      {:ok, %GrowthAndCulture{}}

      iex> update_growth_and_culture(growth_and_culture, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_growth_and_culture(%GrowthAndCulture{} = growth_and_culture, attrs) do
    growth_and_culture
    |> GrowthAndCulture.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a GrowthAndCulture.

  ## Examples

      iex> delete_growth_and_culture(growth_and_culture)
      {:ok, %GrowthAndCulture{}}

      iex> delete_growth_and_culture(growth_and_culture)
      {:error, %Ecto.Changeset{}}

  """
  def delete_growth_and_culture(%GrowthAndCulture{} = growth_and_culture) do
    Repo.delete(growth_and_culture)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking growth_and_culture changes.

  ## Examples

      iex> change_growth_and_culture(growth_and_culture)
      %Ecto.Changeset{source: %GrowthAndCulture{}}

  """
  def change_growth_and_culture(%GrowthAndCulture{} = growth_and_culture) do
    GrowthAndCulture.changeset(growth_and_culture, %{})
  end

  alias Cotizador.FixedCosts.FranchiseFee

  @doc """
  Returns the list of franchise_fees.

  ## Examples

      iex> list_franchise_fees()
      [%FranchiseFee{}, ...]

  """
  def list_franchise_fees do
    Repo.all(FranchiseFee)
  end

  @doc """
  Gets a single franchise_fee.

  Raises `Ecto.NoResultsError` if the Franchise fee does not exist.

  ## Examples

      iex> get_franchise_fee!(123)
      %FranchiseFee{}

      iex> get_franchise_fee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_franchise_fee!(id), do: Repo.get!(FranchiseFee, id)

  @doc """
  Creates a franchise_fee.

  ## Examples

      iex> create_franchise_fee(%{field: value})
      {:ok, %FranchiseFee{}}

      iex> create_franchise_fee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_franchise_fee(attrs \\ %{}) do
    %FranchiseFee{}
    |> FranchiseFee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a franchise_fee.

  ## Examples

      iex> update_franchise_fee(franchise_fee, %{field: new_value})
      {:ok, %FranchiseFee{}}

      iex> update_franchise_fee(franchise_fee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_franchise_fee(%FranchiseFee{} = franchise_fee, attrs) do
    franchise_fee
    |> FranchiseFee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FranchiseFee.

  ## Examples

      iex> delete_franchise_fee(franchise_fee)
      {:ok, %FranchiseFee{}}

      iex> delete_franchise_fee(franchise_fee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_franchise_fee(%FranchiseFee{} = franchise_fee) do
    Repo.delete(franchise_fee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking franchise_fee changes.

  ## Examples

      iex> change_franchise_fee(franchise_fee)
      %Ecto.Changeset{source: %FranchiseFee{}}

  """
  def change_franchise_fee(%FranchiseFee{} = franchise_fee) do
    FranchiseFee.changeset(franchise_fee, %{})
  end

  alias Cotizador.FixedCosts.ExangeRate

  @doc """
  Returns the list of rates.

  ## Examples

      iex> list_rates()
      [%ExangeRate{}, ...]

  """
  def list_rates do
    Repo.all(ExangeRate)
  end

  @doc """
  Gets a single exange_rate.

  Raises `Ecto.NoResultsError` if the Exange rate does not exist.

  ## Examples

      iex> get_exange_rate!(123)
      %ExangeRate{}

      iex> get_exange_rate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exange_rate!(id), do: Repo.get!(ExangeRate, id)

  @doc """
  Creates a exange_rate.

  ## Examples

      iex> create_exange_rate(%{field: value})
      {:ok, %ExangeRate{}}

      iex> create_exange_rate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exange_rate(attrs \\ %{}) do
    %ExangeRate{}
    |> ExangeRate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a exange_rate.

  ## Examples

      iex> update_exange_rate(exange_rate, %{field: new_value})
      {:ok, %ExangeRate{}}

      iex> update_exange_rate(exange_rate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exange_rate(%ExangeRate{} = exange_rate, attrs) do
    exange_rate
    |> ExangeRate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ExangeRate.

  ## Examples

      iex> delete_exange_rate(exange_rate)
      {:ok, %ExangeRate{}}

      iex> delete_exange_rate(exange_rate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exange_rate(%ExangeRate{} = exange_rate) do
    Repo.delete(exange_rate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exange_rate changes.

  ## Examples

      iex> change_exange_rate(exange_rate)
      %Ecto.Changeset{source: %ExangeRate{}}

  """
  def change_exange_rate(%ExangeRate{} = exange_rate) do
    ExangeRate.changeset(exange_rate, %{})
  end
end
