defmodule Cotizador.HumanResourcesTest do
  use Cotizador.DataCase

  alias Cotizador.HumanResources

  describe "positions" do
    alias Cotizador.HumanResources.Position

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def position_fixture(attrs \\ %{}) do
      {:ok, position} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HumanResources.create_position()

      position
    end

    test "list_positions/0 returns all positions" do
      position = position_fixture()
      assert HumanResources.list_positions() == [position]
    end

    test "get_position!/1 returns the position with given id" do
      position = position_fixture()
      assert HumanResources.get_position!(position.id) == position
    end

    test "create_position/1 with valid data creates a position" do
      assert {:ok, %Position{} = position} = HumanResources.create_position(@valid_attrs)
      assert position.name == "some name"
    end

    test "create_position/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HumanResources.create_position(@invalid_attrs)
    end

    test "update_position/2 with valid data updates the position" do
      position = position_fixture()
      assert {:ok, position} = HumanResources.update_position(position, @update_attrs)
      assert %Position{} = position
      assert position.name == "some updated name"
    end

    test "update_position/2 with invalid data returns error changeset" do
      position = position_fixture()
      assert {:error, %Ecto.Changeset{}} = HumanResources.update_position(position, @invalid_attrs)
      assert position == HumanResources.get_position!(position.id)
    end

    test "delete_position/1 deletes the position" do
      position = position_fixture()
      assert {:ok, %Position{}} = HumanResources.delete_position(position)
      assert_raise Ecto.NoResultsError, fn -> HumanResources.get_position!(position.id) end
    end

    test "change_position/1 returns a position changeset" do
      position = position_fixture()
      assert %Ecto.Changeset{} = HumanResources.change_position(position)
    end
  end

  describe "persons" do
    alias Cotizador.HumanResources.Headcount

    @valid_attrs %{name: "some name", salary: 120.5}
    @update_attrs %{name: "some updated name", salary: 456.7}
    @invalid_attrs %{name: nil, salary: nil}

    def headcount_fixture(attrs \\ %{}) do
      {:ok, headcount} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HumanResources.create_headcount()

      headcount
    end

    test "list_persons/0 returns all persons" do
      headcount = headcount_fixture()
      assert HumanResources.list_persons() == [headcount]
    end

    test "get_headcount!/1 returns the headcount with given id" do
      headcount = headcount_fixture()
      assert HumanResources.get_headcount!(headcount.id) == headcount
    end

    test "create_headcount/1 with valid data creates a headcount" do
      assert {:ok, %Headcount{} = headcount} = HumanResources.create_headcount(@valid_attrs)
      assert headcount.name == "some name"
      assert headcount.salary == 120.5
    end

    test "create_headcount/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HumanResources.create_headcount(@invalid_attrs)
    end

    test "update_headcount/2 with valid data updates the headcount" do
      headcount = headcount_fixture()
      assert {:ok, headcount} = HumanResources.update_headcount(headcount, @update_attrs)
      assert %Headcount{} = headcount
      assert headcount.name == "some updated name"
      assert headcount.salary == 456.7
    end

    test "update_headcount/2 with invalid data returns error changeset" do
      headcount = headcount_fixture()
      assert {:error, %Ecto.Changeset{}} = HumanResources.update_headcount(headcount, @invalid_attrs)
      assert headcount == HumanResources.get_headcount!(headcount.id)
    end

    test "delete_headcount/1 deletes the headcount" do
      headcount = headcount_fixture()
      assert {:ok, %Headcount{}} = HumanResources.delete_headcount(headcount)
      assert_raise Ecto.NoResultsError, fn -> HumanResources.get_headcount!(headcount.id) end
    end

    test "change_headcount/1 returns a headcount changeset" do
      headcount = headcount_fixture()
      assert %Ecto.Changeset{} = HumanResources.change_headcount(headcount)
    end
  end
end
