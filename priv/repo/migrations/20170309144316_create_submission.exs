defmodule WebgeeksRaffle.Repo.Migrations.CreateSubmission do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :first_name, :string
      add :last_name, :string
      add :job_title, :string
      add :twitter_handle, :string
      add :email, :string

      timestamps()
    end
    create unique_index(:submissions, [:email, :twitter_handle])

  end
end
