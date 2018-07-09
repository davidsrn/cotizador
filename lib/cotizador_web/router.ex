defmodule CotizadorWeb.Router do
  use CotizadorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CotizadorWeb do
    pipe_through :browser # Use the default browser stack
    resources "/locations", LocationController
    resources "/operations", OperationController
    resources "/items", EquipmentController
    resources "/growth_and_culture", GrowthAndCultureController
    resources "/positions", PositionController
    resources "/persons", HeadcountController
    resources "/rates", ExangeRateController
    resources "/franchise_fees", FranchiseFeeController
    get "/calc", CalculatorController, :index

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CotizadorWeb do
  #   pipe_through :api
  # end
end
