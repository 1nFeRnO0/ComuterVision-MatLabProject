#include "servo_pwm.hpp"
#include <filesystem>
#include <thread>
#include <chrono>
#include <stdexcept>

Servo::Servo(int chip, int channel) : current_angle(0) {
    export_pwm(chip, channel);
    pwm_path = "/sys/class/pwm/pwmchip" + std::to_string(chip) + "/pwm" + std::to_string(channel);

    write("period", "20000000"); // 20 ms
    write("enable", "1");
    set(0);  // начальный угол
}

Servo::~Servo() {
    write("enable", "0");
    unexport_pwm(0, 0);  // можно обобщить
}

void Servo::write(const std::string& file, const std::string& value) {
    std::ofstream fs(pwm_path + "/" + file);
    if (!fs.is_open()) throw std::runtime_error("Can't open " + file);
    fs << value;
    fs.close();
}

void Servo::export_pwm(int chip, int channel) {
    std::string chip_path = "/sys/class/pwm/pwmchip" + std::to_string(chip);
    std::string pwm_path = chip_path + "/pwm" + std::to_string(channel);

    if (!std::filesystem::exists(pwm_path)) {
        std::ofstream fs(chip_path + "/export");
        fs << channel;
        fs.close();
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}

void Servo::unexport_pwm(int chip, int channel) {
    std::ofstream fs("/sys/class/pwm/pwmchip" + std::to_string(chip) + "/unexport");
    fs << channel;
    fs.close();
}

int Servo::angleToDuty(int angle) {
    int min_ns = 1000000;
    int max_ns = 2000000;
    return min_ns + (angle * (max_ns - min_ns)) / 180;
}

void Servo::set(int angle) {
    current_angle = angle;
    int duty = angleToDuty(angle);
    write("duty_cycle", std::to_string(duty));
}