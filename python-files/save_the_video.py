from WorkWithCamera import *

filename = 'video_for_tests_bolts_and_nuts1.mp4v'
fps=60.0
resolution=(640, 640)
fourcc = cv2.VideoWriter_fourcc(*'XVID') 

def main():
	cams = create_camera()
	out = cv2.VideoWriter(filename, fourcc, fps, resolution)
	while True:
		for cam in cams:
			frame = get_frames(cam)
			out.write(frame)
			cv2.imshow('frame', frame)
			if (cv2.waitKey(1) & 0xFF) == ord('q'):
				break
	out.release()	



if __name__=='__main__':
	main()