# Скрипт для проверки интеграции камнры и Yolo
from ultralytics import YOLO
from WorkWithCamera import create_camera, get_frames
import cv2
from FrameProcessing import analyze_frame, check_prob_limit



# -------
def main_loop():
	# Создаем модель Yolo
	model = YOLO('./models/antons_model_100.pt')

	# Переменные счетчика пропуска фреймов и ограничения вероятности
	skip_count = 0
	prob_limit = 0.8

	cams = create_camera()
	while (cv2.waitKey(1) & 0xFF) != ord('q'):
		for cam in cams:
			frame = get_frames(cam)
			
			if frame is not None and skip_count == 0:
				
				# Обрабатываем фрейм с помощью Yolo
				results = analyze_frame(frame, model)
				if check_prob_limit(results, prob_limit):
					skip_count = 15
					# continue
				cv2.imshow("{} Press q to end".format(cam.DevInfo.GetFriendlyName()), results.plot())
			else:
				skip_count -= 1
				if frame is None:
						break
	for cam in cams:
		cam.close()

def main():
	try:
		main_loop()
	finally:
		cv2.destroyAllWindows()

main()
