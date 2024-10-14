int ledPin = 2;  // Пин, к которому подключен светодиод
char incomingData;  // Переменная для хранения данных от компьютера

void setup() {
  pinMode(ledPin, OUTPUT);  // Устанавливаем пин в режим OUTPUT
  Serial.begin(9600);  // Инициализация Serial на скорости 9600
}

void loop() {
  if (Serial.available() > 0) {
    incomingData = Serial.read();  // Чтение данных из Serial
    if (incomingData == 'w') {
      digitalWrite(ledPin, HIGH);  // Включаем светодиод
    } else if (incomingData == 's') {
      digitalWrite(ledPin, LOW);  // Выключаем светодиод
    }
  }
}
