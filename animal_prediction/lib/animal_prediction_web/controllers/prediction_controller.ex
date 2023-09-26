defmodule AnimalPredictionWeb.PredictionController do
  use AnimalPredictionWeb, :controller

  def upload(conn, params) do
    user_name = "anniele"
    date_time = NaiveDateTime.utc_now |> NaiveDateTime.truncate(:second)
    prediction = %AnimalPrediction.Prediction{date_time: date_time, account: nil}
    {:ok, prediction} = AnimalPrediction.Repo.insert(prediction)
    pred_path = AnimalPrediction.ImagesManagement.insert(user_name, params, prediction.id)

    {:ok, res} = AnimalPrediction.YoloModel.detect(pred_path, pred_path, "exp")

    conn
    |> put_status(:ok)
    |> json(%{message: "Image uploaded successfully"})
  end
end
