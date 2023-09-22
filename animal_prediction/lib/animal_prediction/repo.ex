defmodule AnimalPrediction.Repo do
  use Ecto.Repo,
    otp_app: :animal_prediction,
    adapter: Ecto.Adapters.Postgres
end
