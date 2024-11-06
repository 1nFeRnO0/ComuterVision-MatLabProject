#include <Servo.h>

Servo myServo;  // Создаем объект сервопривода
int servoPin = 9;  // Пин для управления сервоприводом
int angle = 90;  // Начальный угол сервопривода (по центру)

void setup() {
  myServo.attach(servoPin);  // Подключаем сервопривод к указанному пину
  myServo.write(angle);  // Устанавливаем начальную позицию
  Serial.begin(9600);  // Инициализация Serial для обмена данными
}

void loop() {
  if (Serial.available() > 0) {
    char command = Serial.read();  // Чтение команды из Serial

    if (command == 'L') {
      //myServo.write(-myServo.read());
      angle = 30;  // Угол 45 градусов влево
      myServo.write(angle);  // Поворачиваем сервопривод
    } else if (command == 'R') {
      //myServo.write(-myServo.read());
      angle = 150;  // Угол 45 градусов вправо от центра
      myServo.write(angle);  // Поворачиваем сервопривод
    }
  }
}
