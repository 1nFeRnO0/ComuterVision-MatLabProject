from ultralytics import YOLO
import cv2
import numpy as np
import torch
import time

model = YOLO('models/best_yolo11n_bolts_nuts.pt')
vid_capture = cv2.VideoCapture('C:/Users/rusla/Desktop/ComuterVision-MatLabProject/videos/capture_line_of_things1.avi')

file_count = 0

skip_count = 0
prob_limit = 0.9

start = time.time()
while(vid_capture.isOpened()):
	
				# Метод vid_capture.read() возвращают кортеж, первым элементом является логическое значение
				# а вторым кадр
	ret, frame = vid_capture.read()
	# if (file_count != 0) and (file_count % 3 == 0):
	#     continue
	if ret and skip_count == 0:
		results = model.predict(frame, device='0')
		prob = results[0].boxes.conf
		# if (len(prob) == 0) or (prob[0].item() < prob_limit):
		# 	skip_count = 15
		# 	continue
		# results[0].save(filename='photos/output.png')
		results_np = results[0].plot()


		cv2.imshow('Look', results_np)
		file_count += 1
		print('Кадр {0:04d}'.format(file_count))
		#writefile = 'Resources/Image_sequence/is42_{0:04d}.jpg'.format(file_count)
		#cv2.imwrite(writefile, frame)
		# 20 в миллисекундах, попробуйте увеличить значение, скажем, 50 и
		# понаблюдайте за изменениями в показе
		key = cv2.waitKey(20)
		
		if (key == ord('q')) or key == 27:
			break
	else:
		skip_count -= 1
		if not ret:
				break
# Освободить объект захвата видео

end = time.time()

result_time = end-start
print(result_time)

vid_capture.release()
cv2.destroyAllWindows()


# img = cv2.imread("C:/Users/rusla/Desktop/cv-tg-bot/photos/photo.jpg")
# results = model.predict(img, device='gpu')
# # results[0].save(filename='photos/output.png')
# results_np = results[0].plot()
# cv2.imshow('test', results_np)
# cv2.waitKey(0)

# # closing all open windows
# cv2.destroyAllWindows()