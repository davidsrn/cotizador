defmodule Cotizador.HumanResources do
  @moduledoc """
  The HumanResources context.
  """

  import Ecto.Query, warn: false
  alias Cotizador.Repo

  alias Cotizador.HumanResources.Position
  alias Cotizador.HumanResources.Headcount

  def get_position_avg do
    pos_id_query =
      from p in Headcount,
      order_by: p.position_id,
      group_by: p.position_id,
      select: p.position_id

    ids =
      Repo.all(pos_id_query)

    for id <- ids do
      %{
        id: id,
        avg: Enum.sum(
          Repo.all(
            from p in Headcount,
            where: p.position_id == ^id,
            select: p.salary
          )
        )
        /
        Enum.count(
          Repo.all(
            from p in Headcount,
            where: p.position_id == ^id,
            select: p.salary
          )
        ),
        name: Repo.one(
          from p in Position,
          where: p.id == ^id,
          group_by: p.name,
          select: p.name
        )
      }
    end

  end

  def get_position_avg(id) do
      Enum.sum(
        Repo.all(
          from p in Headcount,
          where: p.position_id == ^id,
          select: p.salary
        )
      )
      /
      Enum.count(
        Repo.all(
          from p in Headcount,
          where: p.position_id == ^id,
          select: p.salary
        )
      )
  end

  @doc """
  Returns the list of positions.

  ## Examples

      iex> list_positions()
      [%Position{}, ...]

  """
  def list_positions do
    Repo.all(Position)
  end

  @doc """
  Gets a single position.

  Raises `Ecto.NoResultsError` if the Position does not exist.

  ## Examples

      iex> get_position!(123)
      %Position{}

      iex> get_position!(456)
      ** (Ecto.NoResultsError)

  """
  def get_position!(id), do: Repo.get!(Position, id)

  @doc """
  Creates a position.

  ## Examples

      iex> create_position(%{field: value})
      {:ok, %Position{}}

      iex> create_position(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_position(attrs \\ %{}) do
    %Position{}
    |> Position.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a position.

  ## Examples

      iex> update_position(position, %{field: new_value})
      {:ok, %Position{}}

      iex> update_position(position, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_position(%Position{} = position, attrs) do
    position
    |> Position.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Position.

  ## Examples

      iex> delete_position(position)
      {:ok, %Position{}}

      iex> delete_position(position)
      {:error, %Ecto.Changeset{}}

  """
  def delete_position(%Position{} = position) do
    Repo.delete(position)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking position changes.

  ## Examples

      iex> change_position(position)
      %Ecto.Changeset{source: %Position{}}

  """
  def change_position(%Position{} = position) do
    Position.changeset(position, %{})
  end


  @doc """
  Returns the list of persons.

  ## Examples

      iex> list_persons()
      [%Headcount{}, ...]

  """
  def list_persons do
    Repo.all(Headcount)
  end

  @doc """
  Gets a single headcount.

  Raises `Ecto.NoResultsError` if the Headcount does not exist.

  ## Examples

      iex> get_headcount!(123)
      %Headcount{}

      iex> get_headcount!(456)
      ** (Ecto.NoResultsError)

  """
  def get_headcount!(id), do: Repo.get!(Headcount, id)

  @doc """
  Creates a headcount.

  ## Examples

      iex> create_headcount(%{field: value})
      {:ok, %Headcount{}}

      iex> create_headcount(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_headcount(attrs \\ %{}) do
    %Headcount{}
    |> Headcount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a headcount.

  ## Examples

      iex> update_headcount(headcount, %{field: new_value})
      {:ok, %Headcount{}}

      iex> update_headcount(headcount, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_headcount(%Headcount{} = headcount, attrs) do
    headcount
    |> Headcount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Headcount.

  ## Examples

      iex> delete_headcount(headcount)
      {:ok, %Headcount{}}

      iex> delete_headcount(headcount)
      {:error, %Ecto.Changeset{}}

  """
  def delete_headcount(%Headcount{} = headcount) do
    Repo.delete(headcount)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking headcount changes.

  ## Examples

      iex> change_headcount(headcount)
      %Ecto.Changeset{source: %Headcount{}}

  """
  def change_headcount(%Headcount{} = headcount) do
    Headcount.changeset(headcount, %{})
  end
end
