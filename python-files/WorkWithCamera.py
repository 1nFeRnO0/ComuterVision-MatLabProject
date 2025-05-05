import Camera
import mvsdk
import numpy as np
import cv2



def create_camera() -> list:
	# 枚举相机
	DevList = mvsdk.CameraEnumerateDevice()
	nDev = len(DevList)
	if nDev < 1:
		print("No camera was found!")
		return

	for i, DevInfo in enumerate(DevList):
		print("{}: {} {}".format(i, DevInfo.GetFriendlyName(), DevInfo.GetPortType()))

	cams = []
	# for i in map(lambda x: int(x), input("Select cameras: ").split()):
	for i in map(lambda x: int(x), [0]):
		cam = Camera.Camera(DevList[i])
		if cam.open():
			cams.append(cam)
	return cams

def get_frames(camera: Camera) -> np.ndarray:
	frame = camera.grab()
	frame = cv2.resize(frame, (640,640), interpolation = cv2.INTER_LINEAR)
	return frame


# -------
# def main_loop():
# 	# Создаем модель Yolo
# 	model = YOLO('./models/antons_model_100.pt')

# 	# Переменные счетчика пропуска фреймов и ограничения вероятности
# 	skip_count = 0
# 	prob_limit = 0.8

# 	cams = create_camera()
# 	while (cv2.waitKey(1) & 0xFF) != ord('q'):
# 		for cam in cams:
# 			frame = get_frames(cam)
			
# 			if frame is not None and skip_count == 0:
				
# 				# Обрабатываем фрейм с помощью Yolo
# 				results = analyze_frame(frame, model)
# 				if check_prob_limit(results, prob_limit):
# 					skip_count = 15
# 					# continue
# 				cv2.imshow("{} Press q to end".format(cam.DevInfo.GetFriendlyName()), results.plot())
# 			else:
# 				skip_count -= 1
# 				if frame is None:
# 						break
# 	for cam in cams:
# 		cam.close()

# def main():
# 	try:
# 		main_loop()
# 	finally:
# 		cv2.destroyAllWindows()

# main()
