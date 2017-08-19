cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(resource_example CXX C)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/..")

include(binary_resource)
make_binary_resource(
	INPUT main.cpp
	ARRAY_NAME main_src
)

add_executable(${PROJECT_NAME}
	main.cpp
	${CMAKE_CURRENT_BINARY_DIR}/main_src.c
)

target_include_directories(${PROJECT_NAME}
	PRIVATE ${CMAKE_CURRENT_BINARY_DIR}
)
