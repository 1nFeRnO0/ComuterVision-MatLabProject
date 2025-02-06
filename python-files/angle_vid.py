import cv2
import numpy as np
import time

vid_capture = cv2.VideoCapture('./video_for_tests_bolts2.mp4')
file_count = 0

skip_count = 0
prob_limit = 0.8

start = time.time()
while(vid_capture.isOpened()):

    ret, frame = vid_capture.read()

    if ret and skip_count == 0:
        img = frame.copy()
        hh, ww, cc = img.shape
        
        # convert to gray
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        
        # threshold the grayscale image
        ret, thresh = cv2.threshold(gray,100,255,0)
        
        edges = cv2.Canny(thresh, 70, 200)
        #cv2.imshow('test', thresh)
        lines = cv2.HoughLines(edges, 1, np.pi/180, 50)
        rho = 0
        theta = 0
        result = img.copy()
        if lines is not None:
            for rho, theta in lines[0]:
                a = np.cos(theta)
                b = np.sin(theta)
                x0 = a*rho
                y0 = b*rho
                x1 = int(x0 + 1000*(-b))
                y1 = int(y0 + 1000*(a))
                x2 = int(x0 - 1000*(-b))
                y2 = int(y0 - 1000*(a))
    
                cv2.line(result, (x1, y1), (x2, y2), (255, 255, 255), 2)
        # find outer contour
        cntrs = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        cntrs = cntrs[0] if len(cntrs) == 2 else cntrs[1]
        
        # get rotated rectangle from outer contour
        if cntrs:
            rotrect = cv2.minAreaRect(cntrs[0])
            box = cv2.boxPoints(rotrect)
            box = np.int64(box)
            
            # draw rotated rectangle on copy of img as result
            cv2.drawContours(result,[box],0,(0,0,255),2)
            
            # get angle from rotated rectangle
            angle = theta * 180 / np.pi
            # from https://www.pyimagesearch.com/2017/02/20/text-skew-correction-opencv-python/
            # the `cv2.minAreaRect` function returns values in the
            # range [-90, 0); as the rectangle rotates clockwise the
            # returned angle trends to 0 -- in this special case we
            # need to add 90 degrees to the angle
            if angle < -45:
                angle = -(90 + angle)
             
            # otherwise, just take the inverse of the angle to make
            # it positive
            else:
                angle = -angle
            
            print(angle,"deg")
            
            cv2.imshow('lines', thresh)
            cv2.imshow("obj", result)

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
# demo.release()
cv2.destroyAllWindows()
