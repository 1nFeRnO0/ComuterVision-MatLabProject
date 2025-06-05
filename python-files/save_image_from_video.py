import cv2

file_path = '../video_for_tests_bolts_and_nuts1.mp4v'
vid_capture = cv2.VideoCapture(file_path)

file_count = 0

while(vid_capture.isOpened()):
	ret, frame = vid_capture.read()
	frame = cv2.resize(frame, (640,640), interpolation = cv2.INTER_LINEAR)
	cv2.imwrite(f'../images/{file_count}__{file_path.split('/')[-1]}.jpg', frame)
	# print(f'{file_path.split('/')[-1]}')
	file_count += 1

# Освободить объект захвата видео
vid_capture.release()
print(file_count)
