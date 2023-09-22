defmodule AnimalPrediction.Repo.Migrations.CreatePredictions do
  use Ecto.Migration

  def change do
    create table(:predictions) do
      add :date_time, :naive_datetime

      timestamps()
    end
  end
end
