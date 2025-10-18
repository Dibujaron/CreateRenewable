# Claude Context - Create: Renewable Mod

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
- **Version:** 6.0.6-98 (for MC 1.21.1)
- **Maven Repository:** https://maven.createmod.net
- **Artifact:** `com.simibubi.create:create-1.21.1:6.0.6-98:slim`
- **Important:** Must use `:slim` classifier and `transitive = false` to avoid pulling in incompatible dependencies

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
2. Delete old versions from the test instance mods folder
3. Copy the new JAR to `C:\Users\dibuj\curseforge\minecraft\Instances\GC Evergreen\mods`

Usage: `./build-and-deploy.sh` or `build-and-deploy.bat`

### Testing Recipe Changes
- **Full restart required** - `/reload` does NOT work reliably for Create recipes in 1.21.1
- After making recipe changes, run build script and restart Minecraft
- Check logs at: `C:\Users\dibuj\curseforge\minecraft\Instances\GC Evergreen\logs\latest.log`

## Important Notes

1. **Create Dependency Declaration in neoforge.mods.toml:**
   - The mod requires Create to be installed
   - Loads AFTER Create (ordering="AFTER")
   - Version range: [0.5.1,)

2. **Gradle Configuration Issues Encountered:**
   - Initial version `0.5.1.i-76+mc1.21.1` was incorrect
   - Correct version is `6.0.6-98` for MC 1.21.1
   - Must disable transitive dependencies to avoid missing FTB, JourneyMap, Curios, etc.

3. **File Watching Issues:**
   - IntelliJ may auto-save files, causing Edit tool to fail
   - Solution: Close IntelliJ or use bash commands for file modifications

## Create Recipe Format (NeoForge 1.21.1)

### Critical Format Details
After extensive testing, the correct format for Create mixing recipes in NeoForge 1.21.1 was discovered by extracting actual recipes from the Create mod JAR.

**Key differences from older/Fabric versions:**
1. **Directory name:** `data/<namespace>/recipe/` (singular, not "recipes") - this is a Minecraft 1.21+ change
2. **Field names:** Use `heat_requirement` (underscore) NOT `heatRequirement` (camelCase)
3. **Item ingredients:** Use `"item"` field (old format still works for ingredients)
4. **Fluid ingredients:** Must use `{"type": "fluid_stack", "amount": <mb>, "fluid": "<fluid_id>"}`
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
      "type": "fluid_stack",
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
- **Specific fluid:** `{"type": "fluid_stack", "amount": 1000, "fluid": "minecraft:water"}`
- **Fluid tag:** `{"type": "fluid_tag", "amount": 250, "fluid_tag": "c:milk"}`

### Heat Requirements
- `"heated"` - Requires any heat source (fire, lava, or blaze burner)
- `"superheated"` - Requires superheated blaze burner
- Omit field entirely for no heat requirement

### Reference Recipes
Real Create mixing recipes have been extracted to `reference-mods/create-recipes/` for reference.

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
