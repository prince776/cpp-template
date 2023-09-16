cmake_minimum_required(VERSION 3.0.0)
project(cppTemplate VERSION 0.1.0 LANGUAGES C CXX)

set(EXEC_NAME cppTemplate)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} \
-Wall \
-Wextra \
-Wfloat-equal \
-Wundef \
-Wcast-align \
-Wwrite-strings \
-Wmissing-declarations \
-Wredundant-decls \
-Wshadow \
-Woverloaded-virtual \
-fsanitize=address \
-fsanitize=undefined \
-D_GLIBCXX_DEBUG \
-D_GLIBCXX_DEBUG_PEDANTIC \
")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add sources.
file(GLOB_RECURSE SRC_FILES "src/*.cpp")

add_subdirectory(dependencies/expected)
add_subdirectory(dependencies/fmt)
set(ENABLE_CXX, ON)

# Set targets.
add_executable(cppTemplate ${SRC_FILES})
# add_library(cppTemplate STATIC ${SRC_FILES}) # Use this for library.

# Set include directories.
target_include_directories(cppTemplate PRIVATE dependencies/expected/include)
target_include_directories(cppTemplate PRIVATE dependencies/fmt/include)
target_include_directories(cppTemplate PRIVATE src/include)

# Link libraries.
target_link_libraries(cppTemplate PRIVATE expected)
target_link_libraries(cppTemplate PRIVATE fmt)

######### TESTING #########
# Add Google Test as a subdirectory
add_subdirectory(dependencies/googletest)

# Enable testing
enable_testing()

# Collect test source files
file(GLOB TEST_SOURCES "tests/*.cpp")

foreach(TEST_SOURCE ${TEST_SOURCES})
    # Get the test name by removing the file extension
    get_filename_component(TEST_NAME ${TEST_SOURCE} NAME_WE)

    message("Testname is : ${TEST_NAME}")
    # Add the test executable
    add_executable(${TEST_NAME} ${TEST_SOURCE})

    # Link the test executable with Google Test and Corex library
    target_link_libraries(${TEST_NAME} gtest gtest_main)

    # Add test to CTest
    add_test(${TEST_NAME} ${TEST_NAME})
endforeach()


set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
