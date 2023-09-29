defmodule AnimalPrediction.Prediction do
  use Ecto.Schema

  schema "predictions" do
    field :date_time, :naive_datetime

    timestamps()
  end
end
