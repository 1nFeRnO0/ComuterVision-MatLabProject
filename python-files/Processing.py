from WorkWithCamera import *
from FrameProcessing import *
from ultralytics import YOLO
from angle_calc import angle_calc
import cv2
# from work_with_com_port.client import check_cls
from timeit import timeit

def main_loop():
	# Создаем модель Yolo
	model = YOLO('best_yolo11n_bolts_nuts.pt')

	# Переменные счетчика пропуска фреймов и ограничения вероятности
	skip_count = 0
	prob_limit = 0.85
	cams = create_camera()

	while (cv2.waitKey(1) & 0xFF) != ord('q'):
		for cam in cams:
			frame = get_frames(cam)
			if frame is not None:
				if skip_count == 0:
					results = analyze_frame(frame, model)
					# tensor = results.boxes.conf
					if check_prob_limit(results, prob_limit):
					# 	skip_count = 15
					# 	continue
					# if len(tensor) != 0:
					# 	cls = results.boxes.cls[0].item()
						# check_cls(cls)
					# def check_rotate_time():
					ang, ang_result, ang_thresh = angle_calc(frame)

					cv2.imshow("{} YOLO Press q to end".format(cam.DevInfo.GetFriendlyName()), results.plot())
					cv2.imshow("{} Angle Press q to end".format(cam.DevInfo.GetFriendlyName()), ang_result) # Вывод онлайн изображения
					cv2.imshow("thresh Press q to end", ang_thresh)
					print(ang)
					# print(timeit(stmt='check_rotate_time()', globals=locals(), number=1))
				else:
					skip_count -= 1
			else:
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