from WorkWithCamera import *

filename = 'video_for_tests.mp4'
codec='VP90'
fps=60
resolution=(640, 640)
fourcc = cv2.VideoWriter_fourcc(*'mp4v')

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