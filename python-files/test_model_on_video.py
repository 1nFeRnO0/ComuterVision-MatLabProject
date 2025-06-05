from ultralytics import YOLO
import cv2
# import numpy as np
# import torch
import time

model = YOLO('my_dataset_yolo11n_best.pt')
vid_capture = cv2.VideoCapture('video_for_tests_bolts_and_nuts1.mp4')
# Define the codec and create a VideoWriter object  
# fourcc = cv2.VideoWriter_fourcc(*'XVID')  
# demo = cv2.VideoWriter('output.mp4',fourcc, 60.0, (640,640))

file_count = 0

skip_count = 0
prob_limit = 0.8

start = time.time()
while(vid_capture.isOpened()):

	ret, frame = vid_capture.read()
	frame = cv2.resize(frame, (640,640), interpolation = cv2.INTER_LINEAR)

	if ret and skip_count == 0:
		results = model.predict(frame, device='0')
		prob = results[0].boxes.conf
		# if (len(prob) == 0) or (prob[0].item() < prob_limit):
		# 	skip_count = 15
		# 	continue
		results_np = results[0].plot()
		# demo.write(results_np)

		cv2.imshow('Look', results_np)
		file_count += 1
		print('Кадр {0:04d}'.format(file_count))
		key = cv2.waitKey(20)
		
		if (key == ord('q')) or key == 27:
			break
	else:
		skip_count -= 1
		if not ret:
				break
# Освободить объект захвата видео

vid_capture.release()
# demo.release()
cv2.destroyAllWindows()


# img = cv2.imread("C:/Users/rusla/Desktop/cv-tg-bot/photos/photo.jpg")
# results = model.predict(img, device='gpu')
# # results[0].save(filename='photos/output.png')
# results_np = results[0].plot()
# cv2.imshow('test', results_np)
# cv2.waitKey(0)

# # closing all open windows
# cv2.destroyAllWindows()