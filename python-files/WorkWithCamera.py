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
