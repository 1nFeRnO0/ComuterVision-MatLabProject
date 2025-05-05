import gpiod
from threading import Thread
from gpiod.line import Direction, Value
from time import sleep, time

start = time()

SENSOR = 27
LED = 5
chip_name = '/dev/gpiochip0'
DELAY = 0.075

# с ним не работает
#ready = 0

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
#        if ready:
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
#        ready = 1
        while True:
            sleep(DELAY/100)
            val = request.get_value(SENSOR)
            print(1 if val == Value.INACTIVE else 0)
#            if val != Value.ACTIVE:
#                print(val, time() - start)

def main():
    send = Thread(target=send_signal)
    get = Thread(target=get_signal)
    get.start()
    send.start()
    get.join()
    send.join()

if __name__ == '__main__':
    main()

