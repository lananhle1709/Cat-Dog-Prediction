defmodule AnimalPredictionWeb.PredictionController do
  use AnimalPredictionWeb, :controller

  def upload(conn, params) do
    user_name = "anniele"
    date_time = NaiveDateTime.utc_now |> NaiveDateTime.truncate(:second)
    prediction = %AnimalPrediction.Prediction{date_time: date_time}
    {:ok, prediction} = AnimalPrediction.Repo.insert(prediction)
    pred_path = AnimalPrediction.ImagesManagement.insert(user_name, params, prediction.id)

    AnimalPrediction.YoloModel.detect(pred_path, pred_path, "exp")

    images = AnimalPrediction.ImagesManagement.get_exp_images(user_name, prediction.id)

    labels_path = Path.join(pred_path, "exp/labels")
    data = AnimalPrediction.YoloModel.read_outputs(labels_path)

    conn
    |> put_status(:ok)
    |> json(%{files: images, data: data})
  end
end
