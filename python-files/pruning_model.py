from ultralytics.utils.torch_utils import model_info
from ultralytics import YOLO

model = YOLO('models/best_yolo11n_bolts_nuts.pt')

model_info(model, detailed=False, verbose=True, imgsz=640)
