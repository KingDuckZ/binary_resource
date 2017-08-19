cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(resource_example CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/..")

include(binary_resource)
make_binary_resource(
	INPUT main.cpp
	ARRAY_NAME main_src_pvt
)

add_executable(${PROJECT_NAME}
	main.cpp
	main_src.cpp
	${CMAKE_CURRENT_BINARY_DIR}/main_src_pvt.h
)

target_include_directories(${PROJECT_NAME}
	PRIVATE ${CMAKE_CURRENT_BINARY_DIR}
)
