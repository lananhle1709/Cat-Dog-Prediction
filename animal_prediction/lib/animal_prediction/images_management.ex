defmodule AnimalPrediction.ImagesManagement do
  import File
  @dir_path "/Users/eq-0613/Documents/Code/animal_prediction_web/animal_prediction_model/predictions/"

  def insert(user_name, files, pred_id) do
    cur_path = @dir_path <> user_name <> "/"
    pred_path = cur_path <> Integer.to_string(pred_id)

    IO.inspect(cur_path)

    with :ok <- File.mkdir_p(Path.dirname(cur_path)) do
      File.mkdir_p(Path.dirname(pred_path))
    end

    Enum.map(files, fn {file_name, file} ->
      temp_path = file.path
      File.cp(temp_path, Path.join(pred_path, file_name <> ".jpeg"))
    end)
    pred_path
  end
end
