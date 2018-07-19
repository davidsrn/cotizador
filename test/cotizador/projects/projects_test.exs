defmodule Cotizador.ProjectsTest do
  use Cotizador.DataCase

  alias Cotizador.Projects

  describe "projects" do
    alias Cotizador.Projects.Project

    @valid_attrs %{fixed_mxn: 120.5, fixed_usd: 120.5, flat_mxn: 120.5, name: "some name", total_margin_mxn: 120.5, total_margin_usd: 120.5, total_mxn: 120.5, total_usd: 120.5, variable_mxn: 120.5, variable_usd: 120.5}
    @update_attrs %{fixed_mxn: 456.7, fixed_usd: 456.7, flat_mxn: 456.7, name: "some updated name", total_margin_mxn: 456.7, total_margin_usd: 456.7, total_mxn: 456.7, total_usd: 456.7, variable_mxn: 456.7, variable_usd: 456.7}
    @invalid_attrs %{fixed_mxn: nil, fixed_usd: nil, flat_mxn: nil, name: nil, total_margin_mxn: nil, total_margin_usd: nil, total_mxn: nil, total_usd: nil, variable_mxn: nil, variable_usd: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
      assert project.fixed_mxn == 120.5
      assert project.fixed_usd == 120.5
      assert project.flat_mxn == 120.5
      assert project.name == "some name"
      assert project.total_margin_mxn == 120.5
      assert project.total_margin_usd == 120.5
      assert project.total_mxn == 120.5
      assert project.total_usd == 120.5
      assert project.variable_mxn == 120.5
      assert project.variable_usd == 120.5
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = Projects.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.fixed_mxn == 456.7
      assert project.fixed_usd == 456.7
      assert project.flat_mxn == 456.7
      assert project.name == "some updated name"
      assert project.total_margin_mxn == 456.7
      assert project.total_margin_usd == 456.7
      assert project.total_mxn == 456.7
      assert project.total_usd == 456.7
      assert project.variable_mxn == 456.7
      assert project.variable_usd == 456.7
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end
