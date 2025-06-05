import serial
import keyboard
import time

# Подключение к последовательному порту (укажите свой порт)
arduino = serial.Serial('COM5', 9600)  # Убедитесь, что 'COM5' заменен на правильный порт

def send_command(key):
    if key == 'w':
        arduino.write(b'L')  # Отправляем команду 'w' на Arduino
    elif key == 's':
        arduino.write(b'R')  # Отправляем команду 's' на Arduino

# print("Нажмите 'w', чтобы включить светодиод, и 's', чтобы выключить его.")

def check_cls(cls: float):
    # time.sleep(4)
    match cls:
        case 0:  # bolt
            send_command('w')
        case 1: # nut
            send_command('s')


# while True:
#     try:
#         if keyboard.is_pressed('w'):
#             send_command('w')
#         elif keyboard.is_pressed('s'):
#             send_command('s')
#     except:
#         break
