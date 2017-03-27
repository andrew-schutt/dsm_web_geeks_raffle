defmodule WebgeeksRaffle.Repo.Migrations.AddDoubleEntrySubmissions do
  use Ecto.Migration

  def change do
    create table(:double_submissions) do
      add :first_name, :string
      add :last_name, :string
      add :job_title, :string
      add :twitter_handle, :string
      add :email, :string
      add :winner, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:double_submissions, [:email])
    create unique_index(:double_submissions, [:twitter_handle])

  end
end
