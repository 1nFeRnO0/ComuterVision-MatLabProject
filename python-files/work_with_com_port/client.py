import serial
#from python_servo import Servo
from pyservo import Servo
import keyboard
#from gpiozero import AngularServo
#from gpiozero import Servo

#servo = AngularServo(12, initial_angle=0, min_angle=-45, max_angle=45)
#servo = Servo(17)

class PiServo():
    def __init__(self, pin: int):
        args = []
        match pin:
            case 12:
                args = [1, 0]
            case 13:
                args = [1, 1]
            case 18:
                args = [0, 0]
            case 19:
                args = [0, 1]
            case _:
                raise ValueError('Invalid PWM pin')
        chip, canal = args
        self.servo = Servo(chip, canal)

#    def __init__(self, com: str, port: int):
#        self.arduino = serial.Serial(com, port)  # Убедитесь, что 'COM5' заменен на правильный порт

    def check_cls(self, cls: float):
        #print(self.servo.angle)
        match cls:
            case 0:  # bolt
                self.servo.set(45)
                print('turning left')
#                self.arduino.write(b'w')
            case 4: # screw
                self.servo.set(45)
                print('turning left')
#                self.arduino.write(b'w')
            case 1: # nut
                self.servo.set(135)
                print('turning right')
#                self.arduino.write(b's')

#    def send_command(self, key):
#        if key == 'w':
#            self.arduino.write(b'w')  # Отправляем команду 'w' на Arduino
#        elif key == 's':
#            self.arduino.write(b's')  # Отправляем команду 's' на Arduino



# Подключение к последовательному порту (укажите свой порт)


# print("Нажмите 'w', чтобы включить светодиод, и 's', чтобы выключить его.")

servo = PiServo(18)

servo.check_cls(1)

#while True:
#    try:
#        if keyboard.is_pressed('w'):
#            servo.check_cls(1)
#        elif keyboard.is_pressed('s'):
#            servo.check_cls(0)
#    except:
#        break
