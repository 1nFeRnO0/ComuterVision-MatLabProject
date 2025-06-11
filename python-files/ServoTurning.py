import gpiod
import time
from constant_lines import CHIP_NAME, SERVO_LINE

from gpiod.line import Direction, Value

SERVO_LINE = 22

def generate_servo_pulse(angle):
    """Генерация параметров ШИМ для сервопривода MG996R"""
    # Преобразование угла в длительность импульса
    # MG996R: 0.5ms (0°) - 2.5ms (180°)
    pulse_min = 0.5  # ms
    pulse_max = 2.0  # ms
    
    pulse_width_ms = pulse_min + (angle / 180) * (pulse_max - pulse_min)
    pulse_width_sec = pulse_width_ms / 1000.0
    
    # Период ШИМ для сервоприводов (20ms = 50Hz)
    period = 0.02  # 20ms
    
    # Время отключенного состояния
    off_time = period - pulse_width_sec
    
    return pulse_width_sec, off_time

def turning(angle):
    line = gpiod.request_lines(
        CHIP_NAME,
        config={
            SERVO_LINE: gpiod.LineSettings(
                direction=Direction.OUTPUT
            )
        },
    )
    try:
        pulse_width, off_time = generate_servo_pulse(angle)
            # Отправляем 50 импульсов (1 секунда)
        for _ in range(50):
            line.set_value(SERVO_LINE, Value.ACTIVE)
            time.sleep(pulse_width)  # 1.5ms импульс
            line.set_value(SERVO_LINE, Value.INACTIVE)
            time.sleep(off_time)   # Остаток 20ms периода
    except Exception as e:
        print('пиздец, не крутится:', e)


