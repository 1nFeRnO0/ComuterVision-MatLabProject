from ultralytics import YOLO

# Load a pretrained YOLO11n model
model = YOLO("my_dataset_yolo12n_best.pt")

# Run inference on an image
results = model("video_for_tests_bolts_and_nuts1.mp4v", stream=True)
# results = model("image.jpg", show=True)