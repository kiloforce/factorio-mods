local VisualTracerAnim = require("__ownlys_tracers__/libs/VisualTracerAnim")

local function modifyAmmo (ammo)
	if not ammo then
		return
	end
	
	if not ammo.ammo_type then
		return
	end

	--validAmmo = false
	--for ammoCategory in settings.startup["ownlys_tracers--ammo_categories"].value:gmatch("%S+") do
	--	if ammoCategory == ammo.ammo_category then
	--		validAmmo = true
	--	end
	--end

	--if false == validAmmo then
	--	return
	--end
	if ammo.ammo_category ~= "bullet" then
		return
	end
	local actions = ammo.ammo_type.action
	if actions.type then
		actions = {actions}
	end

	local tracer = "visual-tracer-projectile-normal"
	if string.match(ammo.name, "piercing") then
		tracer = "visual-tracer-projectile-piercing"
	elseif string.match(ammo.name, "uranium") then
		tracer = "visual-tracer-projectile-uranium"
	end

	--local probability = tonumber(string.sub(settings.startup["ownlys_tracers--probability"].value, 1, -2)) or 0
	--table.insert(actions,
	--{
	--	type = "direct",
	--	probability = probability < 100 and probability / 100 or nil,
	--	action_delivery =
	--	{
	--		{
	--			type = "projectile",
	--			projectile = tracer,
	--			starting_speed = settings.startup["ownlys_tracers--speed"].value,
	--			starting_speed_deviation = settings.startup["ownlys_tracers--speed_deviation"].value,
	--			direction_deviation = settings.startup["ownlys_tracers--direction_deviation"].value,
	--			max_range = settings.startup["ownlys_tracers--range"].value,
	--			range_deviation = settings.startup["ownlys_tracers--range_deviation"].value,
	--		},
	--	},
	--})
	
	ammo.ammo_type =
    {
	  --target_type = "direction",
      action =
      {
        type = "direct",
        action_delivery =
			{
				type = "projectile",
				projectile = tracer,
				starting_speed = settings.startup["ownlys_tracers--speed"].value,
				starting_speed_deviation = settings.startup["ownlys_tracers--speed_deviation"].value,
				direction_deviation = settings.startup["ownlys_tracers--direction_deviation"].value,
				max_range = settings.startup["ownlys_tracers--misfires"].value and settings.startup["ownlys_tracers--range"].value or nil,
				range_deviation = settings.startup["ownlys_tracers--range_deviation"].value,
			},
      }
    }
	if settings.startup["ownlys_tracers--misfires"].value and settings.startup["ownlys_tracers--directional_targeting"].value then
		ammo.ammo_type.target_type = "direction"
	end
	if settings.startup["ownlys_tracers--magazine_size"].value ~=10 then
		ammo.magazine_size=settings.startup["ownlys_tracers--magazine_size"].value
	end
	--ammo.ammo_type.action = actions
end

for _, prototype in pairs(data.raw["ammo"]) do
	modifyAmmo(prototype)
end

local function modifyShotgun ()
	local shotgun_scale = 2/3
	local shotgun_tint = {r=0.5,g=0.5,b=0.5,a=0.5}
	local pellet = data.raw["projectile"]["shotgun-pellet"]
	if nil ~= pellet then
		--pellet.animation = VisualTracerAnim.generate(
		--0.8,
		--{r = 1, g = 0.8, b = 0.4, a = 0.5},
		--1.2,
		--{r = 1, g = 0.5, b = 0.2, a = 0.3},
		--10
		--)
		pellet.animation = {
			filename = "__ownlys_tracers__/graphics/railgun-beam-y.png",
			priority = "extra-high",
			width = 16,
			height = 496,
			frame_count = 17,
			animation_speed = 1,
			draw_as_glow = true,
			blend_mode = "additive",
			shift = {0,6.75*shotgun_scale},
			rotate_shift =true,
			scale=shotgun_scale,
			tint = shotgun_tint,
		}
	end

	pellet = data.raw["projectile"]["piercing-shotgun-pellet"]
	if nil ~= pellet then
		--pellet.animation = VisualTracerAnim.generate(
		--	0.8,
		--	{r = 1, g = 0.6, b = 0.3, a = 0.6},
		--	1.2,
		--	{r = 1, g = 0.4, b = 0.2, a = 0.4},
		--	10
		--)
		pellet.animation = {
			filename = "__ownlys_tracers__/graphics/railgun-beam-r.png",
			priority = "extra-high",
			width = 16,
			height = 496,
			frame_count = 17,
			animation_speed = 1,
			draw_as_glow = true,
			blend_mode = "additive",
			shift = {0,6.75*shotgun_scale},
			rotate_shift =true,
			scale=shotgun_scale,
			tint = shotgun_tint,
		}
	end
	local pellet = data.raw["projectile"]["uranium-shotgun-pellet"]
	if nil ~= pellet then
		pellet.animation = {
			filename = "__ownlys_tracers__/graphics/railgun-beam-g.png",
			priority = "extra-high",
			width = 16,
			height = 496,
			frame_count = 17,
			animation_speed = 1,
			draw_as_glow = true,
			blend_mode = "additive",
			shift = {0,6.75*shotgun_scale},
			rotate_shift =true,
			scale=shotgun_scale,
			tint = shotgun_tint,
		}
	end
end

modifyShotgun()

for a,b in pairs(data.raw["gun"]) do
	if b.attack_parameters then 
		if b.attack_parameters.ammo_category == "bullet" then
			b.attack_parameters.projectile_creation_distance = math.max(0.1,settings.startup["ownlys_tracers--scale"].value-0.5)
		elseif b.attack_parameters.ammo_category == "shotgun-shell" then
			b.attack_parameters.projectile_creation_distance = 1
		end
	end
end

for a,b in pairs(data.raw["ammo-turret"]) do
	if b.attack_parameters and b.attack_parameters.ammo_category == "bullet" then
		b.attack_parameters.lead_target_for_projectile_speed=settings.startup["ownlys_tracers--speed"].value
		if settings.startup["ownlys_tracers--misfires"].value then
			b.attack_parameters.range = math.min(b.attack_parameters.range, settings.startup["ownlys_tracers--range"].value+2)
		end
		if b.attack_parameters.projectile_creation_distance then
			--b.attack_parameters.projectile_creation_distance = b.attack_parameters.projectile_creation_distance+math.max(0,settings.startup["ownlys_tracers--scale"].value*1.3-0.35)
			b.attack_parameters.projectile_creation_distance = b.attack_parameters.projectile_creation_distance-1
			if b.attack_parameters.shell_particle then
				b.attack_parameters.shell_particle.creation_distance=(b.attack_parameters.shell_particle.creation_distance or -1.88) + 1
			end
		end
	end
end

if settings.startup["ownlys_tracers--misfires"].value and settings.startup["ownlys_tracers--player_lead_target"].value then
	for a,b in pairs(data.raw["gun"]) do
		if b.attack_parameters and b.attack_parameters.ammo_category == "bullet" then
			b.attack_parameters.lead_target_for_projectile_speed=settings.startup["ownlys_tracers--speed"].value
			--b.attack_parameters.lead_target_for_projectile_delay=1 --doesnt help
		end
	end
end
if settings.startup["ownlys_tracers--mech_armor"].value then
	for a,b in pairs(data.raw["gun"]) do
		--if b.attack_parameters and b.attack_parameters.ammo_category == "bullet" then
		--	b.attack_parameters.lead_target_for_projectile_speed=settings.startup["ownlys_tracers--speed"].value
		--	--b.attack_parameters.lead_target_for_projectile_delay=1 --doesnt help
		--end
		b.attack_parameters.projectile_center = {0, -0.0575}
	end
end