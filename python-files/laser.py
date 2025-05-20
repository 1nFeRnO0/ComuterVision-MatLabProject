from gpiozero import LineSensor, LED
from threading import Thread

def send_signal():
    led = LED(5)
    print(led)
    led.on()
    #else:
    #    led.off()
            
def get_signal():
    sensor = LineSensor(27)
    print(sensor)
    sensor.when_activated = lambda: print(1)
    sensor.when_deactivated = lambda: print(0)
#    while True:
#        print(sensor.value)

def main():
    #send = Thread(target=send_signal)
    #get = Thread(target=get_signal)
    get_signal()
    send_signal()
    #send.run()
    #send.join()
    #print('1st')
    #get.run()
    #get.join()
    #print('2nd')

if __name__ == '__main__':
    main()

