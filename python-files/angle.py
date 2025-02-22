import cv2
import numpy as np

def rotate_img(img: cv2.UMat) -> cv2.UMat:
# load image as HSV and select saturation
    # img = cv2.imread("test.png")
    hh, ww, cc = img.shape

    # convert to gray
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # threshold the grayscale image
    #ret, thresh = cv2.threshold(gray,0,255,0)

    edges = cv2.Canny(gray, 150, 250)

    # find outer contour
    cntrs = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cntrs = cntrs[0] if len(cntrs) == 2 else cntrs[1]

    # get rotated rectangle from outer contour
    rotrect = cv2.minAreaRect(cntrs[0])
    box = cv2.boxPoints(rotrect)
    box = np.int64(box)

    # draw rotated rectangle on copy of img as result
    result = img.copy()
    #cv2.drawContours(result,[box],0,(0,0,255),2)

    # get angle from rotated rectangle
    angle = rotrect[-1]

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

    from scipy import ndimage

    result = ndimage.rotate(result, angle)
    #return result
    # write result to disk
    #cv2.imwrite("test_rotate.png", result)

    #cv2.imshow("THRESH", edges)
    #cv2.imshow("RESULT", result)
    #cv2.waitKey(0)
    #cv2.destroyAllWindows()
