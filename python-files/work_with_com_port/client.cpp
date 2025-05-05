#include <iostream>
#include <windows.h>

HANDLE hSerial;
DCB dcbSerialParams = {0};
COMMTIMEOUTS timeouts = {0};

// Функция для открытия последовательного порта
bool openSerialPort(const char *portName) {
    hSerial = CreateFile(
        portName, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

    if (hSerial == INVALID_HANDLE_VALUE) {
        std::cerr << "Ошибка открытия порта" << std::endl;
        return false;
    }

    dcbSerialParams.DCBlength = sizeof(dcbSerialParams);
    if (!GetCommState(hSerial, &dcbSerialParams)) {
        std::cerr << "Не удалось получить состояние COM-порта" << std::endl;
        return false;
    }

    dcbSerialParams.BaudRate = CBR_9600;
    dcbSerialParams.ByteSize = 8;
    dcbSerialParams.StopBits = ONESTOPBIT;
    dcbSerialParams.Parity = NOPARITY;

    if (!SetCommState(hSerial, &dcbSerialParams)) {
        std::cerr << "Не удалось настроить COM-порт" << std::endl;
        return false;
    }

    timeouts.ReadIntervalTimeout = 50;
    timeouts.ReadTotalTimeoutConstant = 50;
    timeouts.ReadTotalTimeoutMultiplier = 10;
    timeouts.WriteTotalTimeoutConstant = 50;
    timeouts.WriteTotalTimeoutMultiplier = 10;

    if (!SetCommTimeouts(hSerial, &timeouts)) {
        std::cerr << "Ошибка настройки таймаутов COM-порта" << std::endl;
        return false;
    }

    return true;
}

// Функция для отправки данных в последовательный порт
void sendData(const char *data) {
    DWORD bytes_written;
    if (!WriteFile(hSerial, data, 1, &bytes_written, NULL)) {
        std::cerr << "Ошибка отправки данных" << std::endl;
    }
}

int main() {
    setlocale(LC_CTYPE, "rus");   // Открываем последовательный порт (замените "COM3" на ваш порт)
    if (!openSerialPort("COM5")) {
        return 1;
    }

    std::cout << "Нажмите 'w', чтобы включить светодиод, и 's', чтобы выключить его." << std::endl;

    // Основной цикл программы
    while (true) {
        // Отслеживание нажатия клавиши 'w'
        if (GetAsyncKeyState('W') & 0x8000) {
            sendData("w");  // Отправка команды 'w' на Arduino
            Sleep(100);  // Небольшая задержка, чтобы избежать повторных срабатываний
        }

        // Отслеживание нажатия клавиши 's'
        if (GetAsyncKeyState('S') & 0x8000) {
            sendData("s");  // Отправка команды 's' на Arduino
            Sleep(100);  // Небольшая задержка, чтобы избежать повторных срабатываний
        }
    }

    // Закрытие последовательного порта
    CloseHandle(hSerial);
    return 0;
}
