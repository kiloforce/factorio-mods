data:extend({
    -- Runtime settings
    {
        type = "bool-setting",
        name = "visible-planets-regen-renders",
        setting_type = "runtime-global",
        default_value = false,
        order = "a[main]-a"
    },
    {
        type = "double-setting",
        name = "visible-planets-planet-init-scale",
        setting_type = "runtime-global",
        default_value = 0.0, -- Will be clamped to planet-scale's value at runtime.
        minimum_value = 0.0,
        order = "b[sprite]-a"
    },
    {
        type = "double-setting",
        name = "visible-planets-planet-scale",
        setting_type = "runtime-global",
        default_value = 6.0,
        minimum_value = 0.0,
        order = "b[sprite]-b"
    },
    {
        type = "int-setting",
        name = "visible-planets-planet-pos-x",
        setting_type = "runtime-global",
        default_value = -75,
        order = "b[sprite]-c"
    },
    {
        type = "int-setting",
        name = "visible-planets-planet-pos-y",
        setting_type = "runtime-global",
        default_value = 20,
        order = "b[sprite]-d"
    },
    {
        type = "int-setting",
        name = "visible-planets-planet-init-dist", -- Could use a rename, but eh migrations are annoying.
        setting_type = "runtime-global",
        default_value = 200,
        minimum_value = 0, -- Always in front of platform, so players don't get confused with whether or not to use a negative number here.
        order = "b[sprite]-e"
    },
    {
        type = "int-setting",
        name = "visible-planets-planet-anim-dur",
        setting_type = "runtime-global",
        default_value = 300,
        minimum_value = 1, -- Avoid division by zero
        order = "b[sprite]-f"
    },
    {
        type = "int-setting",
        name = "visible-planets-planet-angle",
        setting_type = "runtime-global",
        default_value = 0,
        minimum_value = 0,
        maximum_value = 359,
        order = "b[sprite]-g"
    },
    {
        type = "bool-setting",
        name = "visible-planets-enable-parallax",
        setting_type = "runtime-global",
        default_value = true,
        order = "c[parallax]-a"
    },
    {
        type = "double-setting",
        name = "visible-planets-parallax-factor",
        setting_type = "runtime-global",
        default_value = 3,
        minimum_value = 0.1,
        order = "c[parallax]-b"
    },
    {
        type = "bool-setting",
        name = "visible-planets-enable-rotation",
        setting_type = "runtime-global",
        default_value = true,
        order = "d[rotation]-a"
    },
    {
        type = "double-setting",
        name = "visible-planets-rotation-speed",
        setting_type = "runtime-global",
        default_value = 0.01,
        minimum_value = -180,
        maximum_value = 180,
        order = "d[rotation]-b"
    },
    -- Startup settings
    {
        type = "bool-setting",
        name = "visible-planets-override-show-planets",
        setting_type = "startup",
        default_value = false,
        order = "a[general]-a"
    },
    {
        type = "bool-setting",
        name = "visible-planets-planetslib-compat",
        setting_type = "startup",
        default_value = true,
        order = "b[planetslib]-a"
    },
    {
        type = "double-setting",
        name = "visible-planets-planetslib-scale",
        setting_type = "startup",
        default_value = 0.2,
        minimum_value = 0,
        maximum_value = 10,
        order = "b[planetslib]-b"
    },
    {
        type = "double-setting",
        name = "visible-planets-planetslib-x",
        setting_type = "startup",
        default_value = -7.5,
        order = "b[planetslib]-c"
    },
    {
        type = "double-setting",
        name = "visible-planets-planetslib-y",
        setting_type = "startup",
        default_value = -7.5,
        order = "b[planetslib]-d"
    },
    {
        type = "double-setting",
        name = "visible-planets-planetslib-tint",
        setting_type = "startup",
        default_value = 0.5,
        minimum_value = 0,
        maximum_value = 1,
        order = "b[planetslib]-e"
    }
})