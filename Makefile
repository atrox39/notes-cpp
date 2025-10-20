# --- Variables de Configuración ---
# Directorios de compilación separados para Release y Debug
RELEASE_DIR := build/Release
DEBUG_DIR := build/Debug

# Nombre del ejecutable final
TARGET := notes

# --- Declaración de Objetivos "Falsos" ---
# Le dice a Make que estos no son nombres de archivos
.PHONY: all release debug build-release build-debug run-release run-debug clean

# --- Objetivos Principales ---

# Objetivo por defecto: compila la versión de Release
all: release

# Compila la versión de Release completa (instala dependencias y compila)
release: build-release

# Compila la versión de Debug completa (instala dependencias y compila)
debug: build-debug

# --- Flujo de Compilación (Release) ---

# Instala dependencias y configura el proyecto para Release
install-release:
	@echo "--- Configurando para Release... ---"
	conan install . -s build_type=Release --output-folder=$(RELEASE_DIR) --build=missing
	cmake -B $(RELEASE_DIR) \
		-DCMAKE_TOOLCHAIN_FILE=$(RELEASE_DIR)/generators/conan_toolchain.cmake \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Compila el código en modo Release
build-release: install-release
	@echo "--- Compilando en modo Release... ---"
	cmake --build $(RELEASE_DIR)

# Ejecuta el binario de Release
run-release:
	@echo "--- Ejecutando $(TARGET) (Release)... ---"
	./$(RELEASE_DIR)/bin/$(TARGET)

# --- Flujo de Compilación (Debug) ---

# Instala dependencias y configura el proyecto para Debug
install-debug:
	@echo "--- Configurando para Debug... ---"
	conan install . -s build_type=Debug --output-folder=$(DEBUG_DIR) --build=missing
	cmake -B $(DEBUG_DIR) \
		-DCMAKE_TOOLCHAIN_FILE=$(DEBUG_DIR)/generators/conan_toolchain.cmake \
		-DCMAKE_BUILD_TYPE=Debug \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Compila el código en modo Debug
build-debug: install-debug
	@echo "--- Compilando en modo Debug... ---"
	cmake --build $(DEBUG_DIR)

# Ejecuta el binario de Debug
run-debug:
	@echo "--- Ejecutando $(TARGET) (Debug)... ---"
	./$(DEBUG_DIR)/bin/$(TARGET)

# --- Limpieza ---

# Elimina todos los artefactos de compilación
clean:
	@echo "--- Limpiando directorios de compilación... ---"
	rm -rf build
