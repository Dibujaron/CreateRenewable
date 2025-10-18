#!/bin/bash
# Build and deploy CreateRenewable mod to test instance

echo "Building mod..."
./gradlew build
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

echo "Build successful!"
echo "Copying to mods folder..."

TARGET_DIR="/c/Users/dibuj/curseforge/minecraft/Instances/GC Evergreen/mods"
JAR_FILE="build/libs/createrenewable-0.1.0.jar"

# Remove old versions of the mod
rm -f "$TARGET_DIR"/createrenewable-*.jar

# Copy new version
cp "$JAR_FILE" "$TARGET_DIR/"
if [ $? -ne 0 ]; then
    echo "Copy failed!"
    exit 1
fi

echo "Successfully deployed to: $TARGET_DIR"
echo "Done!"
