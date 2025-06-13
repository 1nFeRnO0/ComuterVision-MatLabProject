from gpiozero import LineSensor, LED
from threading import Thread

def send_signal():
    led = LED(5)
    print(led)
    led.on()
            
def get_signal():
    sensor = LineSensor(27)
    print(sensor)
    sensor.when_activated = lambda: print(1)
    sensor.when_deactivated = lambda: print(0)

def main():
    get_signal()
    send_signal()

if __name__ == '__main__':
    main()

