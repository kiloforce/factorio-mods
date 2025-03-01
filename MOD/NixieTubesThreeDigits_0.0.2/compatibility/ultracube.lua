if mods["Ultracube"] then
    require "__Ultracube__/prototypes/lib/tech_costs"
	require "__Ultracube__/prototypes/lib/mystery"
    data:extend({{
        type = "recipe",
        name = "cube-nixie-tube",
        ingredients = {{"cube-electronic-circuit", 1}, {"cube-glass", 2}, {"cube-basic-matter-unit", 2}},
        results = {{"nixie-tube", 1}},
        energy_required = 1,
        category = "cube-fabricator-handcraft",
        enabled = false
    }, {
        type = "recipe",
        name = "cube-nixie-tube-alpha",
        ingredients = {{"cube-electronic-circuit", 1}, {"cube-glass", 2}, {"cube-basic-matter-unit", 2}},
        results = {{"nixie-tube-alpha", 1}},
        energy_required = 1,
        category = "cube-fabricator-handcraft",
        enabled = false
    }, {
        type = "recipe",
        name = "cube-nixie-tube-small",
        ingredients = {{"cube-electronic-circuit", 1}, {"cube-glass", 1}, {"cube-basic-matter-unit", 1}},
        results = {{"nixie-tube-small", 1}},
        energy_required = 1,
        category = "cube-fabricator-handcraft",
        enabled = false
    }, {
        type = "recipe",
        name = "cube-nixie-tube-triplet",
        ingredients = {{"cube-electronic-circuit", 1}, {"cube-glass", 1}, {"cube-basic-matter-unit", 1}},
        results = {{"nixie-tube-triplet", 1}},
        energy_required = 1,
        category = "cube-fabricator-handcraft",
        enabled = false
    }, {
        type = "technology",
        name = "cathodes",
        icon_size = 226,
        icon_mipmaps = 4,
        icon = "__NixieTubesThreeDigits__/graphics/nixie-technology-icon.png",
        effects = {{
            type = "unlock-recipe",
            recipe = "cube-nixie-tube"
        }, {
            type = "unlock-recipe",
            recipe = "cube-nixie-tube-alpha"
        }, {
            type = "unlock-recipe",
            recipe = "cube-nixie-tube-small"
        }, {
            type = "unlock-recipe",
            recipe = "cube-nixie-tube-triplet"
        }},
        prerequisites = {"cube-combinatorics", "cube-crusher"},
        unit = tech_cost_unit("1a", 60),
        order = "x-0-0"
    }})

    add_mystery_recipe(1, "nixie-tube", "cube-glass")
    add_mystery_recipe(1, "nixie-tube-alpha", "cube-glass")
    add_mystery_recipe(1, "nixie-tube-small", "cube-glass")
    add_mystery_recipe(1, "nixie-tube-triplet", "cube-glass")

    data.raw.item["nixie-tube"].subgroup = "cube-combinator-extra"
    data.raw.item["nixie-tube"].order = "cube-y"
    data.raw.item["nixie-tube-alpha"].subgroup = "cube-combinator-extra"
    data.raw.item["nixie-tube-alpha"].order = "cube-y"
    data.raw.item["nixie-tube-small"].subgroup = "cube-combinator-extra"
    data.raw.item["nixie-tube-small"].order = "cube-y"
    data.raw.item["nixie-tube-triplet"].subgroup = "cube-combinator-extra"
    data.raw.item["nixie-tube-triplet"].order = "cube-y"

end
