cmake_minimum_required(VERSION 2.6)

project(EVN_PROJECT)

include_directories("./Network")
add_subdirectory(Network)

add_executable(EVN_PROJECT evn.cpp)
target_link_libraries(EVN_PROJECT Network)