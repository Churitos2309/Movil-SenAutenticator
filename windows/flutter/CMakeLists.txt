cmake_minimum_required(VERSION 3.10)

# Set the project name
project(SENAuthenticator)

# Define the root project directory
set(PROJECT_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

# Define the build directory
set(BUILD_DIR "${CMAKE_BINARY_DIR}")

# Define the ephemeral directory
set(EPHEMERAL_DIR "${BUILD_DIR}/flutter/ephemeral")

# Check if the generated config file exists
# Verificación del archivo generated_config.cmake en la ubicación correcta
set(EPHEMERAL_DIR "${BUILD_DIR}/windows/flutter/ephemeral")
if(EXISTS "${EPHEMERAL_DIR}/generated_config.cmake")
    include("${EPHEMERAL_DIR}/generated_config.cmake")
else()
    message(FATAL_ERROR "Could not find generated_config.cmake in ${EPHEMERAL_DIR}. Make sure it has been generated correctly.")
endif()


# Set variables in the correct scope
set(FLUTTER_LIBRARY "${BUILD_DIR}/flutter/bin/cache/artifacts/engine/windows/flutter_windows.dll" CACHE STRING "Path to Flutter library")
set(FLUTTER_ICU_DATA_FILE "${EPHEMERAL_DIR}/icudtl.dat" CACHE STRING "Path to ICU data file")
set(PROJECT_BUILD_DIR "${BUILD_DIR}" CACHE STRING "Project build directory")
set(AOT_LIBRARY "${BUILD_DIR}/windows/app.so" CACHE STRING "Path to AOT library")

# Add Flutter library headers
list(APPEND FLUTTER_LIBRARY_HEADERS
  "flutter_export.h"
  "flutter_windows.h"
  "flutter_messenger.h"
  "flutter_plugin_registrar.h"
  "flutter_texture_registrar.h"
)
list(TRANSFORM FLUTTER_LIBRARY_HEADERS PREPEND "${EPHEMERAL_DIR}/")
add_library(flutter INTERFACE)
target_include_directories(flutter INTERFACE "${EPHEMERAL_DIR}")

# Apply standard settings if needed
# include("${CMAKE_CURRENT_SOURCE_DIR}/path/to/apply_standard_settings.cmake")

# Add the executable
add_executable(${PROJECT_NAME} "main.cpp")

# Link the Flutter library
target_link_libraries(${PROJECT_NAME} ${FLUTTER_LIBRARY})
