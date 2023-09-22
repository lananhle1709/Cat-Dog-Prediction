defmodule AnimalPrediction.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :user_name, :string
      add :password, :string

      timestamps()
    end
  end
end
