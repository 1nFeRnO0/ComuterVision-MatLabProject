#pragma once
#include <string>
#include <fstream>
#include <atomic>

class Servo {
public:
    Servo(int chip, int channel);
    ~Servo();

    void set(int angle);

private:
    std::string pwm_path;
    int current_angle;

    void write(const std::string& file, const std::string& value);
    void export_pwm(int chip, int channel);
    void unexport_pwm(int chip, int channel);
    int angleToDuty(int angle);
};