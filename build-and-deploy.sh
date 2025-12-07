#!/bin/bash
# Build and deploy CreateRenewable mod to test instance

echo "Copying logo to resources..."
cp logo/logo.png src/main/resources/icon.png
if [ $? -ne 0 ]; then
    echo "Logo copy failed!"
    exit 1
fi

echo "Building mod..."
./gradlew build
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

echo "Build successful!"
echo "Copying to mods folder..."

# Extract version from gradle.properties
MOD_VERSION=$(grep "^mod_version=" gradle.properties | cut -d'=' -f2)

TARGET_DIR="/c/Users/dibuj/curseforge/minecraft/Instances/Evergreen S1/mods"
JAR_FILE="build/libs/CreateRenewables-NeoForge-${MOD_VERSION}.jar"

# Rename old versions of the mod to .disabled so they can be restored later
for jar in "$TARGET_DIR"/createrenewable-*.jar "$TARGET_DIR"/CreateRenewable*.jar; do
    if [ -f "$jar" ]; then
        mv "$jar" "$jar.disabled"
        echo "Renamed existing mod to: $(basename "$jar").disabled"
    fi
done

# Copy new version
cp "$JAR_FILE" "$TARGET_DIR/"
if [ $? -ne 0 ]; then
    echo "Copy failed!"
    exit 1
fi

echo "Successfully deployed to: $TARGET_DIR"
echo "Done!"
