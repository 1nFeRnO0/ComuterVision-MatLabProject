from WorkWithCamera import *
from FrameProcessing import *
from ultralytics import YOLO
import cv2
from work_with_com_port.client import check_cls

def main_loop():
	# Создаем модель Yolo
	model = YOLO('models/best_yolo11n_bolts_nuts.pt')

	# Переменные счетчика пропуска фреймов и ограничения вероятности
	skip_count = 0
	prob_limit = 0.8
	cams = create_camera()

	while (cv2.waitKey(1) & 0xFF) != ord('q'):
		for cam in cams:
			frame = get_frames(cam)
			if frame is not None and skip_count == 0:
				results = analyze_frame(frame, model)
				if check_prob_limit(results, prob_limit):
					skip_count = 15
					continue
				
				cls = results.boxes.cls[0].item()
				check_cls(cls)
				

				cv2.imshow("{} Press q to end".format(cam.DevInfo.GetFriendlyName()), results.plot())
				# cv2.imshow("{} Press q to end".format(cam.DevInfo.GetFriendlyName()), frame) # Вывод онлайн изображения
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

if __name__ == "__main__":
	main()