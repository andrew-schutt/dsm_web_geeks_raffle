defmodule WebgeeksRaffle.SubmissionController do
  require IEx

  use WebgeeksRaffle.Web, :controller

  alias WebgeeksRaffle.Submission

  def index(conn, _params) do
    submissions = Repo.all(Submission)
    render(conn, "index.html", submissions: submissions)
  end

  def new(conn, _params) do
    changeset = Submission.changeset(%Submission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"submission" => submission_params}) do
    changeset = Submission.changeset(%Submission{}, submission_params)

    case Repo.insert(changeset) do
      {:ok, _submission} ->
        conn
        |> put_flash(:info, "Submission created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, errors: changeset.errors)
    end
  end

  def show(conn, %{"id" => id}) do
    submission = Repo.get!(Submission, id)
    render(conn, "show.html", submission: submission)
  end

  def edit(conn, %{"id" => id}) do
    submission = Repo.get!(Submission, id)
    changeset = Submission.changeset(submission)
    render(conn, "edit.html", submission: submission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "submission" => submission_params}) do
    submission = Repo.get!(Submission, id)
    changeset = Submission.changeset(submission, submission_params)

    case Repo.update(changeset) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission updated successfully.")
        |> redirect(to: submission_path(conn, :show, submission))
      {:error, changeset} ->
        render(conn, "edit.html", submission: submission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    submission = Repo.get!(Submission, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(submission)

    conn
    |> put_flash(:info, "Submission deleted successfully.")
    |> redirect(to: submission_path(conn, :index))
  end

  def draw_winner(conn, _params) do
    submissions = Repo.all(Submission)
    winner = Enum.random(submissions)
    conn
    |> put_flash(:info, "Winner was: #{winner.twitter_handle}")
    |> redirect(to: submission_path(conn, :index))

    HTTPoison.post "http://httparrot.herokuapp.com/post", "{\"body\": \"test\"}", [{"Content-Type", "application/json"}]
    {:ok, %HTTPoison.Response{body: "{\n  \"args\": {},\n  \"headers\": {\n    \"host\": \"httparrot.herokuapp.com\",\n    \"connection\": \"close\",\n    \"accept\": \"application/json\",\n    \"content-type\": \"application/json\",\n    \"user-agent\": \"hackney/1.6.1\",\n    \"x-request-id\": \"4b85de44-6227-4480-b506-e3b9b4f0318a\",\n    \"x-forwarded-for\": \"76.174.231.199\",\n    \"x-forwarded-proto\": \"http\",\n    \"x-forwarded-port\": \"80\",\n    \"via\": \"1.1 vegur\",\n    \"connect-time\": \"1\",\n    \"x-request-start\": \"1475945832992\",\n    \"total-route-time\": \"0\",\n    \"content-length\": \"16\"\n  },\n  \"url\": \"http://httparrot.herokuapp.com/post\",\n  \"origin\": \"10.180.37.142\",\n  \"form\": {},\n  \"data\": \"{\\\"body\\\": \\\"test\\\"}\",\n  \"json\": {\n    \"body\": \"test\"\n  }\n}",
        headers: [{"Connection", "keep-alive"}, {"Server", "Cowboy"},
        {"Date", "Sat, 08 Oct 2016 16:57:12 GMT"}, {"Content-Length", "681"},
        {"Content-Type", "application/json"}, {"Via", "1.1 vegur"}],
    status_code: 200}}
  end
end
