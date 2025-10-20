cmake_minimum_required(VERSION 3.15)
project(notes CXX)

# 1. Especifica los componentes. Esto crea el "kit" wx::wx.
find_package(wxWidgets COMPONENTS core base gl REQUIRED)

# Opcional: Configura dónde se guardará el .exe
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# 2. Añade tu ejecutable.
add_executable(notes WIN32 src/main.cpp)

# 3. Enlaza con el "kit" completo wx::wx.
#    Esto se encarga de TODO: bibliotecas, rutas de inclusión, etc.
target_link_libraries(notes PRIVATE ${wxWidgets_LIBRARIES})

# 4. Configura la instalación (esto está bien como lo tenías)
install(TARGETS notes DESTINATION "."
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
)
