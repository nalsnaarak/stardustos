set(MINIZ_VERSION "2.1.0")
if(NOT EXISTS "${miniz_BINARY_DIR}/miniz.zip")
  execute_process(COMMAND curl -L "https://github.com/richgel999/miniz/releases/download/${MINIZ_VERSION}/miniz-${MINIZ_VERSION}.zip" -o "${miniz_BINARY_DIR}/miniz.zip")
  execute_process(COMMAND unzip "${miniz_BINARY_DIR}/miniz.zip" -d "${miniz_BINARY_DIR}/miniz-${MINIZ_VERSION}/")
endif()
add_compile_definitions("MINIZ_NO_STDIO" "MINIZ_NO_TIME")
include_directories("${miniz_BINARY_DIR}/miniz-${MINIZ_VERSION}/")
set(MINIZ_SOURCES "${miniz_BINARY_DIR}/miniz-${MINIZ_VERSION}/miniz.c")