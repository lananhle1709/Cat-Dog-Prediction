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

  def get_pred_path(user_name, id) when is_integer(id) do
    cur_path = Path.join(@dir_path, user_name)
    Path.join(cur_path, Integer.to_string(id))
  end

  def get_pred_path(user_name, id) do
    cur_path = Path.join(@dir_path, user_name)
    Path.join(cur_path, id)
  end

  def get_exp_images(user_name, pred_id) do
    pred_path = get_pred_path(user_name, pred_id)
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
    images
  end
end
