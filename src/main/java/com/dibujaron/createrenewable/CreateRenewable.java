package com.dibujaron.createrenewable;

import org.slf4j.Logger;
import com.mojang.logging.LogUtils;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.common.Mod;
import net.neoforged.fml.ModContainer;

@Mod(CreateRenewable.MOD_ID)
public class CreateRenewable {
    public static final String MOD_ID = "createrenewable";
    public static final Logger LOGGER = LogUtils.getLogger();

    public CreateRenewable(IEventBus modEventBus, ModContainer modContainer) {
        LOGGER.info("Create: Renewable mod initializing...");
        
        // TODO: Register custom recipes here
    }
}
