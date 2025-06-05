import gpiod
import time

from gpiod.line import Direction, Value

LINE = 17

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

def main():
    # chip = gpiod.Chip('/dev/gpiochip0')
    line = gpiod.request_lines(
        "/dev/gpiochip0",
        config={
            LINE: gpiod.LineSettings(
                direction=Direction.OUTPUT
            )
        },
    )
    # line.request(consumer="servo", type=gpiod.LINE_REQ_DIR_OUT)

    try:
        while True:
            # Движение по часовой стрелке (180°)
            print("→ По часовой: 180°")
            pulse_width, off_time = generate_servo_pulse(180)

            # Отправляем 50 импульсов (1 секунда)
            for _ in range(50):
                line.set_value(LINE, Value.ACTIVE)
                time.sleep(pulse_width)  # 1.5ms импульс
                line.set_value(LINE, Value.INACTIVE)
                time.sleep(off_time)   # Остаток 20ms периода

            time.sleep(4)

            # Движение по часовой стрелке (180°)
            print("← Против часовой: 0°")
            pulse_width, off_time = generate_servo_pulse(0)

            # Отправляем 50 импульсов (1 секунда)
            for _ in range(50):
                line.set_value(LINE, Value.ACTIVE)
                time.sleep(pulse_width)  # 1.5ms импульс
                line.set_value(LINE, Value.INACTIVE)
                time.sleep(off_time)   # Остаток 20ms периода

            time.sleep(4)
    except KeyboardInterrupt:
        print("\nОстановка")
    finally:
        # Гарантированное освобождение ресурсов
        line.set_value(LINE, Value.INACTIVE)
        line.release()

if __name__ == "__main__":
    main()


