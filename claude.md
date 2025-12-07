# Claude Context - Create: Renewables Mod

## Project Overview
This is a NeoForge 1.21.1 mod that adds recipes to the Create mod to make late-game items renewable.

**Developer:** dibujaron (dibujaron@gmail.com)
**Repository:** https://github.com/Dibujaron/CreateRenewable
**License:** MIT
**Mod ID:** `createrenewable`
**Package:** `com.dibujaron.createrenewable`
**Main Class:** `src/main/java/com/dibujaron/createrenewable/CreateRenewable.java`

### Target Renewable Items
The mod focuses on making these four key items renewable through advanced late-game recipes:
- **Copper** - Essential for Create's machinery and electrical components
- **Zinc** - Required for brass production and various Create components
- **Blaze Rods** - Needed for blaze burners and other heated processes
- **Netherrack** - Used in various Create recipes and builds

## Key Configuration Details

### Create Mod Dependency
- **Build Dependency Version:** 6.0.6-98 (for MC 1.21.1)
- **Runtime Test Version:** 6.0.8 (what's installed in test instance)
- **Maven Repository:** https://maven.createmod.net
- **Artifact:** `com.simibubi.create:create-1.21.1:6.0.6-98:slim`
- **Important:** Must use `:slim` classifier and `transitive = false` to avoid pulling in incompatible dependencies
- **Note:** We build against 6.0.6-98 (latest in Maven) but test with 6.0.8 (latest release). The mod is compatible with both.

### Build System
- **Gradle Plugin:** NeoGradle 7.0.192
- **Java Version:** 21
- **NeoForge Version:** 21.1.211
- **Minecraft Version:** 1.21.1

### Additional Dependencies
- **Registrate:** `com.tterrag.registrate:Registrate:MC1.21-1.3.0+62`
- **Repository:** https://maven.tterrag.com/

## Build Commands
```bash
./gradlew build          # Build the mod
./gradlew runClient      # Run Minecraft client with mod loaded
./gradlew runServer      # Run Minecraft server with mod loaded
./gradlew runData        # Run data generators
```

## Project Structure
```
src/main/
├── java/com/dibujaron/createrenewable/
│   └── CreateRenewable.java          # Main mod class
└── resources/
    ├── META-INF/
    │   └── neoforge.mods.toml         # Mod metadata (includes Create dependency)
    ├── assets/createrenewable/
    │   └── lang/
    │       └── en_us.json             # Localization
    └── data/createrenewable/
        └── recipe/                    # Recipe JSON files (NOTE: singular "recipe" in 1.21+)
            └── iron_to_zinc_mixing.json
```

## Development Workflow

### Build and Deploy Scripts
Two scripts are provided for rapid iteration during development:
- **build-and-deploy.bat** - For Windows Command Prompt
- **build-and-deploy.sh** - For Git Bash/Unix shells

Both scripts:
1. Build the mod with Gradle
2. Rename old versions in the test instance mods folder to `.disabled` (so they can be restored)
3. Copy the new JAR to `C:\Users\dibuj\curseforge\minecraft\Instances\Evergreen S1\mods`

Usage: `./build-and-deploy.sh` or `build-and-deploy.bat`

### Version Management
**IMPORTANT:** Always bump the version in `gradle.properties` when making changes to recipes, features, or bug fixes!
- Edit `mod_version` in `gradle.properties` (e.g., 1.2 → 1.3)
- Follow semantic versioning: MAJOR.MINOR for this mod
- The build script automatically uses this version for the JAR filename

### Testing Recipe Changes
- **Current Test Instance:** `Evergreen S1`
- **Full restart required** - `/reload` does NOT work reliably for Create recipes in 1.21.1
- After making recipe changes, run build script and restart Minecraft
- Check logs at: `C:\Users\dibuj\curseforge\minecraft\Instances\Evergreen S1\logs\latest.log`

## Important Notes

1. **Version Management:** **ALWAYS** bump `mod_version` in `gradle.properties` before building when you make recipe changes, bug fixes, or add features!

2. **Create Dependency Declaration in neoforge.mods.toml:**
   - The mod requires Create to be installed
   - Loads AFTER Create (ordering="AFTER")
   - Version range: [0.5.1,)

3. **Gradle Configuration Issues Encountered:**
   - Initial version `0.5.1.i-76+mc1.21.1` was incorrect
   - Correct build version is `6.0.6-98` for MC 1.21.1 (latest available in Maven)
   - Runtime testing uses `6.0.8` (latest release, not yet in Maven for dev)
   - Must disable transitive dependencies to avoid missing FTB, JourneyMap, Curios, etc.

4. **File Watching Issues:**
   - IntelliJ may auto-save files, causing Edit tool to fail
   - Solution: Close IntelliJ or use bash commands for file modifications

## Create Recipe Format (NeoForge 1.21.1)

### Critical Format Details
After extensive testing, the correct format for Create mixing recipes in NeoForge 1.21.1 was discovered by extracting actual recipes from the Create mod JAR.

**Key differences from older/Fabric versions:**
1. **Directory name:** `data/<namespace>/recipe/` (singular, not "recipes") - this is a Minecraft 1.21+ change
2. **Field names:** Use `heat_requirement` (underscore) NOT `heatRequirement` (camelCase)
3. **Item ingredients:** Use `"item"` field (old format still works for ingredients)
4. **Fluid ingredients (Create 6.0.8+):** Must use `{"type": "neoforge:single", "amount": <mb>, "fluid": "<fluid_id>"}` (old `"fluid_stack"` type still works for backwards compatibility but causes KubeJS warnings)
5. **Results:** Must use `"id"` field (not `"item"`) - this is the 1.21+ format

### Working Mixing Recipe Template
```json
{
  "type": "create:mixing",
  "heat_requirement": "heated",
  "ingredients": [
    {
      "item": "minecraft:item_name"
    },
    {
      "type": "neoforge:single",
      "amount": 1000,
      "fluid": "minecraft:water"
    }
  ],
  "results": [
    {
      "count": 3,
      "id": "minecraft:output_item"
    }
  ]
}
```

### Fluid Ingredient Types
- **Specific fluid (6.0.8+):** `{"type": "neoforge:single", "amount": 1000, "fluid": "minecraft:water"}`
- **Fluid tag:** `{"type": "neoforge:tag", "amount": 250, "fluid_tag": "c:milk"}`

Note: The old `"fluid_stack"` type still works for backwards compatibility but causes KubeJS validation warnings.

### Heat Requirements
- `"heated"` - Requires any heat source (fire, lava, or blaze burner)
- `"superheated"` - Requires superheated blaze burner
- Omit field entirely for no heat requirement

### Reference Recipes
Real Create recipes (version 6.0.8) have been extracted to `reference-mods/create-recipes-6.0.8/` for reference.

## Implemented Recipes

### Zinc Nuggets (Renewable)
**File:** `iron_to_zinc_mixing.json`
**Recipe:** 3 iron nuggets + 1 sea pickle + 50mb lava (heated) → 3 zinc nuggets
**Status:** ✅ Working and tested in-game

## Next Steps / TODO

1. **Copper Nuggets Recipe** - Design and implement renewable copper recipe
2. **Blaze Rods Recipe** - Design and implement renewable blaze rod recipe
3. **Netherrack Recipe** - Design and implement renewable netherrack recipe

## Useful Resources
- NeoForge Docs: https://docs.neoforged.net/docs/1.21.1/
- Create Wiki: https://wiki.createmod.net/
- Create Developers Guide: https://wiki.createmod.net/developers/depend-on-create/neoforge-1.21.1
