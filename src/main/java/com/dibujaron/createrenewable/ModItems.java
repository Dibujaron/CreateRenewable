package com.dibujaron.createrenewable;

import net.minecraft.world.item.Item;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

public final class ModItems {
    public static final DeferredRegister.Items ITEMS = DeferredRegister.createItems(CreateRenewable.MOD_ID);

    // A simple “like a stick” item
    public static final DeferredItem<Item> PARTIAL_BLAZE_ROD =
            ITEMS.registerSimpleItem("incomplete_blaze_rod", new Item.Properties().stacksTo(64));

    public static void register(IEventBus modBus) {
        ITEMS.register(modBus);
    }
}
