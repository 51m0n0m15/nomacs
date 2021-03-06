project (qpsd)
cmake_minimum_required(VERSION 2.6)

if(COMMAND cmake_policy)
	cmake_policy(SET CMP0003 NEW)
	  
	IF(CMAKE_VERSION VERSION_GREATER 2.8.10)
		cmake_policy(SET CMP0020 NEW)	# qt warnings
	ENDIF()
  IF(CMAKE_VERSION VERSION_GREATER 2.8.12.9)
    cmake_policy(SET CMP0043 NEW)	# COMPILE_DEFINITIONS_<CONFIG> warnings
  ENDIF()
endif(COMMAND cmake_policy)



file(GLOB LIBQPSD_SOURCES "*.cpp")
file(GLOB LIBQPSD_HEADERS "*.h")

SET(CMAKE_DEBUG_POSTFIX "d")

add_library(${PROJECT_NAME} SHARED ${LIBQPSD_SOURCES})
target_link_libraries(${PROJECT_NAME} ${QT_LIBRARIES})

qt5_use_modules(${PROJECT_NAME} Gui)

set_target_properties(${PROJECT_NAME} PROPERTIES ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_CURRENT_BINARY_DIR}/libs)
set_target_properties(${PROJECT_NAME} PROPERTIES ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_CURRENT_BINARY_DIR}/libs)
set_target_properties(${PROJECT_NAME} PROPERTIES ARCHIVE_OUTPUT_DIRECTORY_REALLYRELEASE ${CMAKE_CURRENT_BINARY_DIR}/libs)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E make_directory ${NOMACS_BUILD_DIRECTORY}/$<CONFIGURATION>/imageformats/)
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:qpsd> ${NOMACS_BUILD_DIRECTORY}/$<CONFIGURATION>/imageformats/)
