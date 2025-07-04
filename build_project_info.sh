#!/bin/bash

# Caminho base
PROJECT_DIR="$HOME/ProjectInfo"
ZIP_FILE="ProjectInfo.zip"

# Verifica se o .zip existe
if [ ! -f "$ZIP_FILE" ]; then
    echo "Arquivo $ZIP_FILE não encontrado no diretório atual!"
    exit 1
fi

# Extrair projeto
rm -rf "$PROJECT_DIR"
unzip "$ZIP_FILE" -d "$HOME" || exit 1

cd "$PROJECT_DIR" || exit 1

# Inicializa Gradle
if [ ! -f "./gradlew" ]; then
    echo "Gradle Wrapper não encontrado. Inicializando..."
    gradle wrapper || exit 1
fi

# Compila o APK
chmod +x ./gradlew
./gradlew assembleDebug

# Verifica se o APK foi gerado
APK_PATH=$(find . -name "*debug.apk" | head -n 1)
if [ -f "$APK_PATH" ]; then
    echo "✅ APK compilado com sucesso: $APK_PATH"
else
    echo "❌ Erro: APK não foi gerado."
    exit 1
fi
