#include <pybind11/pybind11.h>
#include "servo_pwm.hpp"

namespace py = pybind11;

PYBIND11_MODULE(pyservo, m) {
    py::class_<Servo>(m, "Servo")
        .def(py::init<int, int>())  // chip, channel
        .def("set", &Servo::set);
}