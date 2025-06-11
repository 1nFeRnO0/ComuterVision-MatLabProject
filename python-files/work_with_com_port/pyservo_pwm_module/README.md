# PyServo (Аппаратный PWM)

Python-модуль для управления сервоприводом на Raspberry Pi 5 через аппаратный PWM.

## Сборка

```bash
sudo apt install cmake g++ python3-dev libpython3-dev
pip install pybind11
mkdir build && cd build
cmake ..
make
```

## Использование

```python
from pyservo import Servo

s = Servo(0, 0)  # pwmchip0, канал 0
s.set(90)        # Установить угол 90°
```

> Убедитесь, что у вас включён PWM в /boot/config.txt или через raspi-config.