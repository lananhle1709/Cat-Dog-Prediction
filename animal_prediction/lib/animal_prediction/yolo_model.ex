defmodule AnimalPrediction.YoloModel do
  @model_path "/Users/eq-0613/Documents/Code/animal_prediction_web/animal_prediction_model/"
  @yolo_path Path.join(@model_path, "yolov5")
  @weight_path Path.join(@model_path, "weights/best.pt")
  @img_size 416
  @conf 0.5
  @line_thickness 1

  def detect(src_path, des_path, name) do
    cmd = "python3 #{@yolo_path}/detect.py --weights #{@weight_path} --img #{@img_size} --conf #{@conf} --source #{src_path} --save-txt --project #{des_path} --name #{name} --line-thickness #{@line_thickness}"
    System.cmd("sh", ["-c", cmd])
  end
end
