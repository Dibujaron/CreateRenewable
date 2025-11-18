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

TARGET_DIR="/c/Users/dibuj/curseforge/minecraft/Instances/Evergreen s1 v0.4.3/mods"
JAR_FILE="build/libs/CreateRenewables-NeoForge-1.0.jar"

# Remove old versions of the mod
rm -f "$TARGET_DIR"/createrenewable-*.jar "$TARGET_DIR"/CreateRenewable*.jar

# Copy new version
cp "$JAR_FILE" "$TARGET_DIR/"
if [ $? -ne 0 ]; then
    echo "Copy failed!"
    exit 1
fi

echo "Successfully deployed to: $TARGET_DIR"
echo "Done!"
