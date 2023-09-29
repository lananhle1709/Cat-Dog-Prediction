defmodule AnimalPrediction.YoloModel do
  @model_path "/Users/eq-0613/Documents/Code/animal_prediction_web/animal_prediction_model/"
  @yolo_path Path.join(@model_path, "yolov5")
  @weight_path Path.join(@model_path, "weights/best.pt")
  @img_size 416
  @conf 0.5
  @line_thickness 1

  def detect(src_path, des_path, name) do
    cmd = "python3 #{@yolo_path}/detect.py --weights #{@weight_path} --img #{@img_size} --conf #{@conf} --source #{src_path} --save-txt --save-conf --project #{des_path} --name #{name}"
    System.cmd("sh", ["-c", cmd])
  end

  def read_outputs(folder_path) do
    {:ok, txt_files} = File.ls(folder_path)

    res = Enum.map(txt_files, fn file ->
      Path.join(folder_path, "/#{file}") |> read_output()
    end)
    res
  end
  def read_output(file_path) do
    {:ok, content} = File.read(file_path)
    lines = String.split(content, ~r/\n/) |> IO.inspect()

    detections = lines
    |> Enum.map(&String.split(&1, " "))
    |> Enum.filter(fn list ->
      length(list) == 6
    end)
    |> Enum.map(fn [class_label, confidence, x_center, y_center, width, height] ->
      class_label = String.to_integer(class_label)
      confidence = String.to_float(confidence)
      x_center = String.to_float(x_center)
      y_center = String.to_float(y_center)
      width = String.to_float(width)
      height = String.to_float(height)

      x_min = x_center - width / 2
      y_min = y_center - height / 2
      x_max = x_center + width / 2
      y_max = y_center + height / 2

      %{
        class_label: class_label,
        confidence: confidence,
        x_min: x_min,
        y_min: y_min,
        x_max: x_max,
        y_max: y_max
      }
    end)

    detections
  end
end
