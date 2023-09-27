defmodule AnimalPredictionWeb.HistoryController do
  use AnimalPredictionWeb, :controller
  def get_all(conn, params) do
    AnimalPrediction.Prediction |> AnimalPrediction.Repo.all |> IO.inspect()
  end
end
