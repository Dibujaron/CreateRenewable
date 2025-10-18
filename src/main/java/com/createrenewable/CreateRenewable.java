package com.createrenewable;

import org.slf4j.Logger;
import com.mojang.logging.LogUtils;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.common.Mod;
import net.neoforged.fml.ModContainer;

@Mod(CreateRenewable.MODID)
public class CreateRenewable {
    public static final String MODID = "createrenewable";
    public static final Logger LOGGER = LogUtils.getLogger();

    public CreateRenewable(IEventBus modEventBus, ModContainer modContainer) {
        LOGGER.info("Create: Renewable mod initializing...");
        
        // TODO: Register custom recipes here
    }
}
