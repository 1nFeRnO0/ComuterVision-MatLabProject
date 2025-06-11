cmake_minimum_required(VERSION 3.14)
project(pyservo)

set(CMAKE_CXX_STANDARD 17)

find_package(pybind11 REQUIRED)

add_library(pyservo MODULE servo_pwm.cpp bindings.cpp)
set_target_properties(pyservo PROPERTIES PREFIX "" SUFFIX ".so")
target_link_libraries(pyservo PRIVATE pybind11::module)

