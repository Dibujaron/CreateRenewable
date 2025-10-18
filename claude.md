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
    └── assets/createrenewable/
        └── lang/
            └── en_us.json             # Localization
```

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

## Next Steps / TODO

1. **Study Create's Recipe System:**
   - Investigate Create's recipe types (Mixing, Crushing, Compacting, etc.)
   - Look at Create's data generation for recipes

2. **Reference Mod:**
   - Decompile Create: Copper & Zinc mod (https://www.curseforge.com/minecraft/mc-mods/create-copper-zinc)
   - Analyze how they add custom recipes to Create

3. **Implementation Plan:**
   - Identify which late-game items to make renewable
   - Design recipe chains using Create's processing methods
   - Add recipes via JSON files in `src/main/resources/data/createrenewable/recipes/`
   - Or use data generators to create recipes programmatically

## Useful Resources
- NeoForge Docs: https://docs.neoforged.net/docs/1.21.1/
- Create Wiki: https://wiki.createmod.net/
- Create Developers Guide: https://wiki.createmod.net/developers/depend-on-create/neoforge-1.21.1
