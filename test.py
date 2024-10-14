from ultralytics import YOLO
import cv2
import numpy as np
import torch


# model = YOLO("y8m_best.pt")
# model = YOLO("C:/Users/rusla/Desktop/cv-tg-bot/runs/detect/train9/weights/best.pt")
# results = model("bus.jpg")
# results[0].show()
# results = model("object.png")
# results[0].show()
# results = model("only_screw_dataset/train/images/IMG_1303_JPG_jpg.rf.5f6e3bfc47deb07e5db6a71a93bcca0c.jpg")
# results[0].show()


vid_capture = cv2.VideoCapture('Resources/is42.mp4')
img = cv2.imread("C:/Users/rusla/Desktop/cv-tg-bot/photos/photo.jpg")
results = model.predict(img, device='gpu')
# results[0].save(filename='photos/output.png')
results_np = results[0].plot()
cv2.imshow('test', results_np)
cv2.waitKey(0)

# # closing all open windows
# cv2.destroyAllWindows()