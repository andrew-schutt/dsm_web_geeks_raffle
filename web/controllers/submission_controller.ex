defmodule WebgeeksRaffle.SubmissionController do
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
    submissions = Repo.all(from subs in Submission, where: subs.winner == false)
    if Enum.empty?(submissions) do
      conn
      |> put_flash(:info, "No eligible winners :(")
      |> redirect(to: submission_path(conn, :index))
    else
      winning_submission = Enum.random(submissions)

      Submission.changeset(winning_submission, %{winner: true})
      |> Repo.update

      ExTwitter.update("Congrats @#{winning_submission.twitter_handle}! You are a raffle winner! #dsmwebgeekfest")

      conn
      |> put_flash(:info, "Winner was: #{winning_submission.first_name} #{winning_submission.last_name} - #{winning_submission.twitter_handle}")
      |> redirect(to: submission_path(conn, :index))
    end
  end
end
