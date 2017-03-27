defmodule WebgeeksRaffle.DoubleSubmissionController do
  use WebgeeksRaffle.Web, :controller

  alias WebgeeksRaffle.DoubleSubmission

  def index(conn, _params) do
    double_submissions = Repo.all(DoubleSubmission)
    render(conn, "index.html", double_submissions: double_submissions)
  end

  def new(conn, _params) do
    changeset = DoubleSubmission.changeset(%DoubleSubmission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"double_submission" => double_submission_params}) do
    changeset = DoubleSubmission.changeset(%DoubleSubmission{}, double_submission_params)

    case Repo.insert(changeset) do
      {:ok, _submission} ->
        conn
        |> put_flash(:info, "DoubleSubmission created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, errors: changeset.errors)
    end
  end

  def show(conn, %{"id" => id}) do
    double_submission = Repo.get!(DoubleSubmission, id)
    render(conn, "show.html", double_submission: double_submission)
  end

  def edit(conn, %{"id" => id}) do
    double_submission = Repo.get!(DoubleSubmission, id)
    changeset = DoubleSubmission.changeset(double_submission)
    render(conn, "edit.html", double_submission: double_submission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "submission" => double_submission_params}) do
    double_submission = Repo.get!(DoubleSubmission, id)
    changeset = DoubleSubmission.changeset(double_submission, double_submission_params)
    case Repo.update(changeset) do
      {:ok, double_submission} ->
        conn
        |> put_flash(:info, "DoubleSubmission updated successfully.")
        |> redirect(to: double_submission_path(conn, :show, double_submission))
      {:error, changeset} ->
        render(conn, "edit.html", double_submission: double_submission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    double_submission = Repo.get!(DoubleSubmission, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(double_submission)

    conn
    |> put_flash(:info, "DoubleSubmission deleted successfully.")
    |> redirect(to: double_submission_path(conn, :index))
  end
end
