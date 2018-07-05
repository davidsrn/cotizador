defmodule Cotizador.FixedCostsTest do
  use Cotizador.DataCase

  alias Cotizador.FixedCosts

  describe "operations" do
    alias Cotizador.FixedCosts.Operation

    @valid_attrs %{date: ~D[2010-04-17], detail: "some detail", item: "some item", monthly_cost: 120.5}
    @update_attrs %{date: ~D[2011-05-18], detail: "some updated detail", item: "some updated item", monthly_cost: 456.7}
    @invalid_attrs %{date: nil, detail: nil, item: nil, monthly_cost: nil}

    def operation_fixture(attrs \\ %{}) do
      {:ok, operation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FixedCosts.create_operation()

      operation
    end

    test "list_operations/0 returns all operations" do
      operation = operation_fixture()
      assert FixedCosts.list_operations() == [operation]
    end

    test "get_operation!/1 returns the operation with given id" do
      operation = operation_fixture()
      assert FixedCosts.get_operation!(operation.id) == operation
    end

    test "create_operation/1 with valid data creates a operation" do
      assert {:ok, %Operation{} = operation} = FixedCosts.create_operation(@valid_attrs)
      assert operation.date == ~D[2010-04-17]
      assert operation.detail == "some detail"
      assert operation.item == "some item"
      assert operation.monthly_cost == 120.5
    end

    test "create_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FixedCosts.create_operation(@invalid_attrs)
    end

    test "update_operation/2 with valid data updates the operation" do
      operation = operation_fixture()
      assert {:ok, operation} = FixedCosts.update_operation(operation, @update_attrs)
      assert %Operation{} = operation
      assert operation.date == ~D[2011-05-18]
      assert operation.detail == "some updated detail"
      assert operation.item == "some updated item"
      assert operation.monthly_cost == 456.7
    end

    test "update_operation/2 with invalid data returns error changeset" do
      operation = operation_fixture()
      assert {:error, %Ecto.Changeset{}} = FixedCosts.update_operation(operation, @invalid_attrs)
      assert operation == FixedCosts.get_operation!(operation.id)
    end

    test "delete_operation/1 deletes the operation" do
      operation = operation_fixture()
      assert {:ok, %Operation{}} = FixedCosts.delete_operation(operation)
      assert_raise Ecto.NoResultsError, fn -> FixedCosts.get_operation!(operation.id) end
    end

    test "change_operation/1 returns a operation changeset" do
      operation = operation_fixture()
      assert %Ecto.Changeset{} = FixedCosts.change_operation(operation)
    end
  end

  describe "items" do
    alias Cotizador.FixedCosts.Equipment

    @valid_attrs %{cost: "some cost", final_date: ~D[2010-04-17], initial_date: ~D[2010-04-17], name: "some name"}
    @update_attrs %{cost: "some updated cost", final_date: ~D[2011-05-18], initial_date: ~D[2011-05-18], name: "some updated name"}
    @invalid_attrs %{cost: nil, final_date: nil, initial_date: nil, name: nil}

    def equipment_fixture(attrs \\ %{}) do
      {:ok, equipment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FixedCosts.create_equipment()

      equipment
    end

    test "list_items/0 returns all items" do
      equipment = equipment_fixture()
      assert FixedCosts.list_items() == [equipment]
    end

    test "get_equipment!/1 returns the equipment with given id" do
      equipment = equipment_fixture()
      assert FixedCosts.get_equipment!(equipment.id) == equipment
    end

    test "create_equipment/1 with valid data creates a equipment" do
      assert {:ok, %Equipment{} = equipment} = FixedCosts.create_equipment(@valid_attrs)
      assert equipment.cost == "some cost"
      assert equipment.final_date == ~D[2010-04-17]
      assert equipment.initial_date == ~D[2010-04-17]
      assert equipment.name == "some name"
    end

    test "create_equipment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FixedCosts.create_equipment(@invalid_attrs)
    end

    test "update_equipment/2 with valid data updates the equipment" do
      equipment = equipment_fixture()
      assert {:ok, equipment} = FixedCosts.update_equipment(equipment, @update_attrs)
      assert %Equipment{} = equipment
      assert equipment.cost == "some updated cost"
      assert equipment.final_date == ~D[2011-05-18]
      assert equipment.initial_date == ~D[2011-05-18]
      assert equipment.name == "some updated name"
    end

    test "update_equipment/2 with invalid data returns error changeset" do
      equipment = equipment_fixture()
      assert {:error, %Ecto.Changeset{}} = FixedCosts.update_equipment(equipment, @invalid_attrs)
      assert equipment == FixedCosts.get_equipment!(equipment.id)
    end

    test "delete_equipment/1 deletes the equipment" do
      equipment = equipment_fixture()
      assert {:ok, %Equipment{}} = FixedCosts.delete_equipment(equipment)
      assert_raise Ecto.NoResultsError, fn -> FixedCosts.get_equipment!(equipment.id) end
    end

    test "change_equipment/1 returns a equipment changeset" do
      equipment = equipment_fixture()
      assert %Ecto.Changeset{} = FixedCosts.change_equipment(equipment)
    end
  end

  describe "growth_and_culture_item" do
    alias Cotizador.FixedCosts.GrowthAndCulture

    @valid_attrs %{date: ~D[2010-04-17], detail: "some detail", name: "some name", yearly_cost: "some yearly_cost"}
    @update_attrs %{date: ~D[2011-05-18], detail: "some updated detail", name: "some updated name", yearly_cost: "some updated yearly_cost"}
    @invalid_attrs %{date: nil, detail: nil, name: nil, yearly_cost: nil}

    def growth_and_culture_fixture(attrs \\ %{}) do
      {:ok, growth_and_culture} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FixedCosts.create_growth_and_culture()

      growth_and_culture
    end

    test "list_growth_and_culture_item/0 returns all growth_and_culture_item" do
      growth_and_culture = growth_and_culture_fixture()
      assert FixedCosts.list_growth_and_culture_item() == [growth_and_culture]
    end

    test "get_growth_and_culture!/1 returns the growth_and_culture with given id" do
      growth_and_culture = growth_and_culture_fixture()
      assert FixedCosts.get_growth_and_culture!(growth_and_culture.id) == growth_and_culture
    end

    test "create_growth_and_culture/1 with valid data creates a growth_and_culture" do
      assert {:ok, %GrowthAndCulture{} = growth_and_culture} = FixedCosts.create_growth_and_culture(@valid_attrs)
      assert growth_and_culture.date == ~D[2010-04-17]
      assert growth_and_culture.detail == "some detail"
      assert growth_and_culture.name == "some name"
      assert growth_and_culture.yearly_cost == "some yearly_cost"
    end

    test "create_growth_and_culture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FixedCosts.create_growth_and_culture(@invalid_attrs)
    end

    test "update_growth_and_culture/2 with valid data updates the growth_and_culture" do
      growth_and_culture = growth_and_culture_fixture()
      assert {:ok, growth_and_culture} = FixedCosts.update_growth_and_culture(growth_and_culture, @update_attrs)
      assert %GrowthAndCulture{} = growth_and_culture
      assert growth_and_culture.date == ~D[2011-05-18]
      assert growth_and_culture.detail == "some updated detail"
      assert growth_and_culture.name == "some updated name"
      assert growth_and_culture.yearly_cost == "some updated yearly_cost"
    end

    test "update_growth_and_culture/2 with invalid data returns error changeset" do
      growth_and_culture = growth_and_culture_fixture()
      assert {:error, %Ecto.Changeset{}} = FixedCosts.update_growth_and_culture(growth_and_culture, @invalid_attrs)
      assert growth_and_culture == FixedCosts.get_growth_and_culture!(growth_and_culture.id)
    end

    test "delete_growth_and_culture/1 deletes the growth_and_culture" do
      growth_and_culture = growth_and_culture_fixture()
      assert {:ok, %GrowthAndCulture{}} = FixedCosts.delete_growth_and_culture(growth_and_culture)
      assert_raise Ecto.NoResultsError, fn -> FixedCosts.get_growth_and_culture!(growth_and_culture.id) end
    end

    test "change_growth_and_culture/1 returns a growth_and_culture changeset" do
      growth_and_culture = growth_and_culture_fixture()
      assert %Ecto.Changeset{} = FixedCosts.change_growth_and_culture(growth_and_culture)
    end
  end

  describe "franchise_fees" do
    alias Cotizador.FixedCosts.FranchiseFee

    @valid_attrs %{name: "some name", value: "some value"}
    @update_attrs %{name: "some updated name", value: "some updated value"}
    @invalid_attrs %{name: nil, value: nil}

    def franchise_fee_fixture(attrs \\ %{}) do
      {:ok, franchise_fee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FixedCosts.create_franchise_fee()

      franchise_fee
    end

    test "list_franchise_fees/0 returns all franchise_fees" do
      franchise_fee = franchise_fee_fixture()
      assert FixedCosts.list_franchise_fees() == [franchise_fee]
    end

    test "get_franchise_fee!/1 returns the franchise_fee with given id" do
      franchise_fee = franchise_fee_fixture()
      assert FixedCosts.get_franchise_fee!(franchise_fee.id) == franchise_fee
    end

    test "create_franchise_fee/1 with valid data creates a franchise_fee" do
      assert {:ok, %FranchiseFee{} = franchise_fee} = FixedCosts.create_franchise_fee(@valid_attrs)
      assert franchise_fee.name == "some name"
      assert franchise_fee.value == "some value"
    end

    test "create_franchise_fee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FixedCosts.create_franchise_fee(@invalid_attrs)
    end

    test "update_franchise_fee/2 with valid data updates the franchise_fee" do
      franchise_fee = franchise_fee_fixture()
      assert {:ok, franchise_fee} = FixedCosts.update_franchise_fee(franchise_fee, @update_attrs)
      assert %FranchiseFee{} = franchise_fee
      assert franchise_fee.name == "some updated name"
      assert franchise_fee.value == "some updated value"
    end

    test "update_franchise_fee/2 with invalid data returns error changeset" do
      franchise_fee = franchise_fee_fixture()
      assert {:error, %Ecto.Changeset{}} = FixedCosts.update_franchise_fee(franchise_fee, @invalid_attrs)
      assert franchise_fee == FixedCosts.get_franchise_fee!(franchise_fee.id)
    end

    test "delete_franchise_fee/1 deletes the franchise_fee" do
      franchise_fee = franchise_fee_fixture()
      assert {:ok, %FranchiseFee{}} = FixedCosts.delete_franchise_fee(franchise_fee)
      assert_raise Ecto.NoResultsError, fn -> FixedCosts.get_franchise_fee!(franchise_fee.id) end
    end

    test "change_franchise_fee/1 returns a franchise_fee changeset" do
      franchise_fee = franchise_fee_fixture()
      assert %Ecto.Changeset{} = FixedCosts.change_franchise_fee(franchise_fee)
    end
  end

  describe "rates" do
    alias Cotizador.FixedCosts.ExangeRate

    @valid_attrs %{amout: "some amout", date: ~D[2010-04-17]}
    @update_attrs %{amout: "some updated amout", date: ~D[2011-05-18]}
    @invalid_attrs %{amout: nil, date: nil}

    def exange_rate_fixture(attrs \\ %{}) do
      {:ok, exange_rate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FixedCosts.create_exange_rate()

      exange_rate
    end

    test "list_rates/0 returns all rates" do
      exange_rate = exange_rate_fixture()
      assert FixedCosts.list_rates() == [exange_rate]
    end

    test "get_exange_rate!/1 returns the exange_rate with given id" do
      exange_rate = exange_rate_fixture()
      assert FixedCosts.get_exange_rate!(exange_rate.id) == exange_rate
    end

    test "create_exange_rate/1 with valid data creates a exange_rate" do
      assert {:ok, %ExangeRate{} = exange_rate} = FixedCosts.create_exange_rate(@valid_attrs)
      assert exange_rate.amout == "some amout"
      assert exange_rate.date == ~D[2010-04-17]
    end

    test "create_exange_rate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FixedCosts.create_exange_rate(@invalid_attrs)
    end

    test "update_exange_rate/2 with valid data updates the exange_rate" do
      exange_rate = exange_rate_fixture()
      assert {:ok, exange_rate} = FixedCosts.update_exange_rate(exange_rate, @update_attrs)
      assert %ExangeRate{} = exange_rate
      assert exange_rate.amout == "some updated amout"
      assert exange_rate.date == ~D[2011-05-18]
    end

    test "update_exange_rate/2 with invalid data returns error changeset" do
      exange_rate = exange_rate_fixture()
      assert {:error, %Ecto.Changeset{}} = FixedCosts.update_exange_rate(exange_rate, @invalid_attrs)
      assert exange_rate == FixedCosts.get_exange_rate!(exange_rate.id)
    end

    test "delete_exange_rate/1 deletes the exange_rate" do
      exange_rate = exange_rate_fixture()
      assert {:ok, %ExangeRate{}} = FixedCosts.delete_exange_rate(exange_rate)
      assert_raise Ecto.NoResultsError, fn -> FixedCosts.get_exange_rate!(exange_rate.id) end
    end

    test "change_exange_rate/1 returns a exange_rate changeset" do
      exange_rate = exange_rate_fixture()
      assert %Ecto.Changeset{} = FixedCosts.change_exange_rate(exange_rate)
    end
  end
end
