defmodule AnimalPredictionWeb.HistoryController do
  use AnimalPredictionWeb, :controller
  def get_all(conn, params) do
    data = AnimalPrediction.Prediction
    |> AnimalPrediction.Repo.all
    |> Enum.map(fn prediction ->
      %{
        "id" => prediction.id,
        "date_time" => prediction.date_time
      }
    end)

    conn
    |> put_status(:ok)
    |> json(%{data: data})
  end

  def get(conn, %{"id" => id}) do
    images = AnimalPrediction.ImagesManagement.get_exp_images("anniele", id)
    conn
    |> put_status(:ok)
    |> json(%{files: images})
  end
end
