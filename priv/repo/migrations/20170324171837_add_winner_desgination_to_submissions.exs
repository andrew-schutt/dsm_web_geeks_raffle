defmodule WebgeeksRaffle.Repo.Migrations.AddWinnerDesginationToSubmissions do
  use Ecto.Migration

  def change do
    alter table(:submissions) do
      add :winner, :boolean, default: false, null: false
    end
  end
end
