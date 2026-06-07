cmake_minimum_required(VERSION 3.22.1)

project(fladder_ass)

add_library(fladder_ass SHARED fladder_ass.cpp)

target_link_libraries(fladder_ass android log dl)
