local VisualTracerAnim = require("__ownlys_tracers__/libs/VisualTracerAnim")

local prototype = {
        type = "projectile",
        name = "visual-tracer-projectile-normal",
        flags = {"not-on-map"},
		--hit_collision_mask = {layers={water_tile=true}},
        --hit_at_collision_position = true,
		hit_at_collision_position = true,
		force_condition = "not-same",--"not-friend",--
		collision_box = {{-0.45*settings.startup["ownlys_tracers--collision_scale"].value, -0.3}, {0.45*settings.startup["ownlys_tracers--collision_scale"].value, 0.3}},
		hit_collision_mask = {
			layers = {
			object = true,
			player = true,
			trigger_target = true,
			train = true
			},
			not_colliding_with_itself = true
		},
		direction_only = settings.startup["ownlys_tracers--misfires"].value, 
		piercing_damage = 1000,
        acceleration = settings.startup["ownlys_tracers--acceleration"].value,
		--projectile_creation_distance = -1.5,
        animation = {
			filename = "__ownlys_tracers__/graphics/railgun-beam-yv.png",
			priority = "extra-high",
			width = 16,
			height = 496,
			frame_count = 17,
			animation_speed = 1,
			draw_as_glow = true,
			blend_mode = "additive",
			shift = {0,6.75},
			rotate_shift =true,
			scale=1,
		},
        light = {intensity = 0.5, size = 4, color = {r = 1, g = 0.8, b = 0.4} },
        action =
        {
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-entity",
						entity_name = "visual-tracer-explosion-hit-normal",
						tile_collision_mask = {layers={water_tile=true}},
					},
					{
						type = "create-entity",
						entity_name = "water-splash",
						tile_collision_mask = {layers={ground_tile=true}},
					},
					{
						type = "damage",
						damage = {amount = 5, type = "physical"}
					},
				},
			},
        },
    }
local p2 = table.deepcopy(prototype)
p2.name = "visual-tracer-projectile-piercing"
--p2.animation = VisualTracerAnim.generate(
--			0.8,
--			{r = 1, g = 0.6, b = 0.3, a = 0.6},
--			1.2,
--			{r = 1, g = 0.4, b = 0.2, a = 0.4},
--			10
--		)
p2.animation.filename = "__ownlys_tracers__/graphics/railgun-beam-rv.png"
p2.light = {intensity = 0.6, size = 4, color = {r = 1, g = 0.6, b = 0.3} }
p2.action.action_delivery.target_effects[3].damage.amount = 8

local p3 = table.deepcopy(prototype)
p3.name="visual-tracer-projectile-uranium"
--p3.animation = VisualTracerAnim.generate(
--			0.8,
--			{r = 0.7, g = 1, b = 0.5, a = 0.6},
--			1.2,
--			{r = 0.6, g = 1, b = 0.4, a = 0.4},
--			10
--		)
p3.animation.filename = "__ownlys_tracers__/graphics/railgun-beam-gv.png"
p3.light = {intensity = 0.6, size = 4, color = {r = 0.7, g = 1, b = 0.5} }
p3.action.action_delivery.target_effects[3].damage.amount = 24

data:extend({
    prototype,
	p2,
	p3,
   
})
