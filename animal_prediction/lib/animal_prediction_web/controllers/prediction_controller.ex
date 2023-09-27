defmodule AnimalPredictionWeb.PredictionController do
  use AnimalPredictionWeb, :controller

  def upload(conn, params) do
    user_name = "anniele"
    date_time = NaiveDateTime.utc_now |> NaiveDateTime.truncate(:second)
    prediction = %AnimalPrediction.Prediction{date_time: date_time, account: nil}
    {:ok, prediction} = AnimalPrediction.Repo.insert(prediction)
    pred_path = AnimalPrediction.ImagesManagement.insert(user_name, params, prediction.id)

    AnimalPrediction.YoloModel.detect(pred_path, pred_path, "exp")

    {:ok, pred_files} = File.ls(Path.join(pred_path, "exp"))
    pred_files = Enum.filter(pred_files, fn file ->
      file != "labels"
    end)
    IO.inspect(pred_files)
    images = Enum.map(pred_files, fn file ->
      file_path = Path.join(pred_path, "exp/#{file}")
      image_data = File.read!(file_path)
      %{data: Base.encode64(image_data)}
    end)

    conn
    |> put_status(:ok)
    |> json(%{files: images})
  end
end
