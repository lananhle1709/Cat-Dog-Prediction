defmodule AnimalPrediction.ImagesManagement do
  import File
  @dir_path "/Users/eq-0613/Documents/Code/animal_prediction_web/animal_prediction_model/predictions/"

  def insert(user_name, files, pred_id) do
    cur_path = Path.join(@dir_path, user_name)
    pred_path = Path.join(cur_path, Integer.to_string(pred_id))

    IO.inspect(pred_path)

    File.mkdir_p!(Path.dirname(pred_path  <> "/"))

    Enum.map(files, fn {file_name, file} ->
      temp_path = file.path
      extension = Path.extname(file.filename)
      File.exists?(temp_path) |> IO.inspect()
      File.cp!(temp_path, Path.join(pred_path, file_name <> extension)) |> IO.inspect()
    end)
    pred_path
  end
end
