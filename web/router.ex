defmodule WebgeeksRaffle.Router do
  use WebgeeksRaffle.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", WebgeeksRaffle do
    pipe_through :browser

    get "/", PageController, :index
    get "/submissions/new", SubmissionController, :new
    post "/submissions", SubmissionController, :create
  end

  scope "/", WebgeeksRaffle do
    pipe_through :protected

    get "submissions/draw_winner", SubmissionController, :draw_winner
    get "/submissions", SubmissionController, :index
    get "/submissions/:id/edit", SubmissionController, :edit
    get "/submissions/:id", SubmissionController, :show
    patch "/submissions/:id", SubmissionController, :update
    put "/submissions/:id", SubmissionController, :update
    delete "/submissions/:id", SubmissionController, :delete

    resources "/double_submissions", DoubleSubmissionController
  end
end
