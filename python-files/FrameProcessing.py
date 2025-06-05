import cv2
import numpy as np
from ultralytics import YOLO
from ultralytics.engine.results import Results

def analyze_frame(frame: np.ndarray, model: YOLO) -> Results:
	results = model.predict(frame, device='0')
	return results[0]

def check_prob_limit(result: Results, prob_limit: float) -> bool:
	tensor = result.boxes.conf
	return (len(tensor) == 0) or (tensor[0].item() < prob_limit)

# def show_frame(result: Results):
# 	cv2.imshow("Press q to end", result.plot())