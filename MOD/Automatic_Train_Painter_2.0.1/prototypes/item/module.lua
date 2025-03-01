local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({
    {
        type = "item",
        name = "manual-color-module",
        icon = "__Automatic_Train_Painter__/graphics/icons/manual-color-module.png",
        place_as_equipment_result = "manual-color-module",
        subgroup = "train-transport",
        order = "d[train-system]-d[manual-color-module]",
        pick_sound = item_sounds.electric_large_inventory_pickup,
        drop_sound = item_sounds.electric_large_inventory_move,
        stack_size = 10
    },
    {
        type = "generator-equipment",
        name = "manual-color-module",
        sprite =
        {
            filename = "__Automatic_Train_Painter__/graphics/equipment/manual-color-module.png",
            width = 128,
            height = 128,
            priority = "medium",
            scale = 0.5
        },
        shape =
        {
            width = 2,
            height = 2,
            type = "full"
        },
        energy_source =
        {
            type = "electric",
            usage_priority = "primary-output"
        },
        power = "1W",
        categories = {"atp-equipment-category"}
    },
})