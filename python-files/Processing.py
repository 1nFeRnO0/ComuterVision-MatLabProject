from WorkWithCamera import *
from FrameProcessing import *
from ultralytics import YOLO
import cv2
import gpiod
from threading import Thread
from gpiod.line import Direction, Value
from time import sleep, time
from work_with_com_port.client import check_cls

start = time()

SENSOR = 27
LED = 5
chip_name = '/dev/gpiochip0'
DELAY = 0.075

def send_signal():
    with gpiod.request_lines(
                chip_name,
                consumer='led-test',
                config={
                        LED: gpiod.LineSettings(
                                direction=Direction.OUTPUT, output_value=Value.ACTIVE
                            ),
                    }
                ) as request:
        while True:
            request.set_value(LED, Value.ACTIVE)
#            sleep(DELAY)
#            request.set_value(LED, Value.INACTIVE)
#            sleep(DELAY)
        else:
            request.set_value(LED, Value.INACTIVE)
            
def get_signal():
    with gpiod.request_lines(
                chip_name,
                consumer='sensor-test',
                config={
                        SENSOR: gpiod.LineSettings(
                                direction=Direction.INPUT
                            ),
                    }
                ) as request:
#        while True:
        sleep(DELAY/100)
        val = request.get_value(SENSOR)
        return 1 if val == Value.INACTIVE else 0

def main_loop():
    # Создаем модель Yolo
    model = YOLO('../models/antons_model11n_200_nut.pt')

    # Переменные счетчика пропуска фреймов и ограничения вероятности
    skip_count = 0
    prob_limit = 0.8
    cams = create_camera()
    sig0 = 0
    sig1 = 0

    while (cv2.waitKey(1) & 0xFF) != ord('q'):
        for cam in cams:
#            for sig1 in get_signal()
            sig1 = get_signal()
            if sig1 == 1 and sig0 == 0:
                print('Found 10')
                frame = get_frames(cam)
                if frame is not None: #and skip_count == 0:
                    results = analyze_frame(frame, model)
#                    if check_prob_limit(results, prob_limit):
#                        skip_count = 15
#                        continue
                    
                    #print(results.boxes.cls)
                    if results.boxes.cls != tensor([]):
                        cls = results.boxes.cls[0].item()
                        check_cls(cls)
                    

                    cv2.imshow("{} Press q to end".format(cam.DevInfo.GetFriendlyName()), results.plot())
#                else:
#                    skip_count -= 1
#                    if frame is None:
#                            break
            sig0 = sig1
    for cam in cams:
        cam.close()

def main():
    try:
        send = Thread(target=send_signal)
        get = Thread(target=main_loop)
        get.start()
        send.start()
        get.join()
        send.join()
    finally:
        cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
