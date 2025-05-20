#import serial
#import keyboard
from gpiozero import AngularServo

servo = AngularServo(17, min_angle=-45, max_angle=45)
print(servo)

# Подключение к последовательному порту (укажите свой порт)
#arduino = serial.Serial('COM5', 9600)  # Убедитесь, что 'COM5' заменен на правильный порт

#def send_command(key):
#    if key == 'w':
#        arduino.write(b'w')  # Отправляем команду 'w' на Arduino
#    elif key == 's':
#        arduino.write(b's')  # Отправляем команду 's' на Arduino

# print("Нажмите 'w', чтобы включить светодиод, и 's', чтобы выключить его.")

def check_cls(cls: float):
    match cls:
        case 0:  # bolt
            servo.min()
            print('turning left')
#            send_command('w')
        case 4: # screw
            servo.min()
            print('turning left')
#            send_command('w')
        case 2: # nut
            servo.max()
            print('turning right')
#            send_command('s')


# while True:
#     try:
#         if keyboard.is_pressed('w'):
#             send_command('w')
#         elif keyboard.is_pressed('s'):
#             send_command('s')
#     except:
#         break
