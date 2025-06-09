// #include <Servo.h> // подключаем библиотеку для работы с сервоприводом

// Servo servo1; // объявляем переменную servo типа "servo1"
// char incomingData;  // Переменная для хранения данных от компьютера

// void setup() {
//    servo1.attach(3); // привязываем сервопривод к аналоговому выходу 11
// }

// void loop() {
//   if (Serial.available() > 0) {
//     incomingData = Serial.read();  // Чтение данных из Seria
//     //Serial.print(incomingData);
//     if (incomingData == 'w') {
//       servo1.write(45);  // Включаем светодиод
//     } else if (incomingData == 's') {
//       servo1.write(135);  // Выключаем светодиод
//     }
//   }
// }

#include <Servo.h>
Servo myservo = Servo();

void setup() {
  myservo.attach(9);  // подключаем на пин 3
  myservo.write(90);
  delay(5000);
}

void loop() {
  myservo.write(0);   // поворот на 0 градусов
  delay(2000);
  Serial.print(myservo.read());
  myservo.write(180);
  delay(2000);
  // myservo.write(180); // поворот на 180 градусов
  // delay(100000);
}