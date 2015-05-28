cmake_minimum_required(VERSION 2.8)

if(NOT DEFINED ENV{FUZZ_MAKE})
MESSAGE(FATAL_ERROR "Don't run this build script directly.")
endif()

set(SNUDOWN_ROOT "${CMAKE_SOURCE_DIR}/../dep/snudown")
set(BYPASS_ROOT "${CMAKE_SOURCE_DIR}/../src")

set(HEADERS
  ${SNUDOWN_ROOT}/houdini/houdini.h
  ${SNUDOWN_ROOT}/houdini/buffer.h
  ${SNUDOWN_ROOT}/houdini/html_unescape.h
  ${SNUDOWN_ROOT}/src/autolink.h
  ${SNUDOWN_ROOT}/src/buffer.h
  ${SNUDOWN_ROOT}/src/html_blocks.h
  ${SNUDOWN_ROOT}/src/html_entities.h
  ${SNUDOWN_ROOT}/src/markdown.h
  ${SNUDOWN_ROOT}/src/stack.h
  ${BYPASS_ROOT}/element.h
  ${BYPASS_ROOT}/document.h
  ${BYPASS_ROOT}/parser.h
  )
set(LIBRARY_SOURCES
  ${SNUDOWN_ROOT}/houdini/houdini_href_e.c
  ${SNUDOWN_ROOT}/houdini/houdini_html_e.c
  ${SNUDOWN_ROOT}/houdini/houdini_html_u.c
  ${SNUDOWN_ROOT}/houdini/buffer.c
  ${SNUDOWN_ROOT}/src/autolink.c
  ${SNUDOWN_ROOT}/src/buffer.c
  ${SNUDOWN_ROOT}/src/markdown.c
  ${SNUDOWN_ROOT}/src/stack.c
  ${BYPASS_ROOT}/element.cpp  
  ${BYPASS_ROOT}/document.cpp
  ${BYPASS_ROOT}/parser.cpp
  ${HEADERS}
  )

set(PROGRAM "bypass-validator")
set(PROGRAM_SOURCES
  ${LIBRARY_SOURCES}
  bypass-validator.cpp
  )

include_directories(. ${SNUDOWN_ROOT}/src ${SNUDOWN_ROOT}/houdini ${BYPASS_ROOT} ${CMAKE_CURRENT_BINARY_DIR})

add_executable(${PROGRAM} ${PROGRAM_SOURCES})

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -g -Wno-error=parentheses")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -g -Wno-error=parentheses")
