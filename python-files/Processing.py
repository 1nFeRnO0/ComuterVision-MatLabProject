from WorkWithCamera import *
from FrameProcessing import *
from ultralytics import YOLO
from torch import tensor
import cv2
from time import sleep, time
#from work_with_com_port.client import check_cls
from constant_lines import *
from IRProcessing import *
from ServoTurning import turning
from constant_lines import MODEL_PATH

def check_cls(cls: float):
    #print(self.servo.angle)
    match cls:
        case 0:  # bolt
            turning(90)
            print('turning left')
        case 1: # screw
            turning(0)
            print('turning left')

def main_loop():
    # Создаем модель Yolo
    model = YOLO(MODEL_PATH)
    cams = create_camera()
    signal_previous = 0
    signal_current = 0

    while (cv2.waitKey(1) & 0xFF) != ord('q'):
        for cam in cams:
#            for signal_current in get_signal()
            signal_current = get_signal()
            if signal_current == 0 and signal_previous == 1:
                print('Found falling edge')
                frame = get_frames(cam)
                if frame is not None:
                    results = analyze_frame(frame, model)
                    
                    if len(results.boxes.cls):
                        cls = results.boxes.cls[0].item()
                        print(cls)
                        check_cls(cls)
                    print('Showing results')
                    cv2.imshow("{} Press q to end".format(cam.DevInfo.GetFriendlyName()), results.plot())
            signal_previous = signal_current
    for cam in cams:
        cam.close()

def main():
    try:
        led_line = send_signal()
        main_loop()
    finally:
        cv2.destroyAllWindows()
        led_line.release()

if __name__ == "__main__":
    main()
