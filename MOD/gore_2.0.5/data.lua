require("load_settings")
particle_shadows = false
particle_premul_alpha = true
puddle_d = 0.9
particlescale = settings.startup["gore-particlescale"].value
local scale        =settings.startup["gore-scale"].value
local splatterscale=settings.startup["gore-splatterscale"].value
local splatterduration=math.max(1,settings.startup["gore-splatterduration"].value*60)

-- blood explosion fx:
--fx_color
local scaler = scale

-- ground decal:
--decal_color
local splatterscaler = splatterscale 
local splatterduration = splatterduration		--duration how long blood decals stay on the floor

local shifter = {0,0.3}
local blender = "normal"
local flagger = {"not-on-map", "placeable-off-grid", "not-flammable"}

require("bloodparticle")
data.raw["optimized-particle"]["blood-particle"].pictures = gore_blood_particle{
	preset = preset,
	scale = particlescale, 
	tint = particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	premul_alpha = particle_premul_alpha
}
if particle_shadows then--particle_r > 0 and particle_g > 0 and particle_b > 0 then
	data.raw["optimized-particle"]["blood-particle"].shadows = gore_blood_particle_shadow{scale = 1*settings.startup["gore-particlescale"].value}
else
	data.raw["optimized-particle"]["blood-particle"].shadows = nil
end

data.raw["optimized-particle"]["blood-particle-small"].pictures = gore_blood_particle{
	preset = preset,
	scale = particlescale, 
	tint = particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	premul_alpha = particle_premul_alpha
}
if particle_shadows then--particle_r > 0 and particle_g > 0 and particle_b > 0 then
	data.raw["optimized-particle"]["blood-particle-small"].shadows = gore_blood_particle_shadow{scale = 1*settings.startup["gore-particlescale"].value}
else
	data.raw["optimized-particle"]["blood-particle-small"].shadows = nil
end

data.raw["optimized-particle"]["blood-particle-carpet-small"].pictures = gore_blood_particle{
	preset = preset,
	scale = particlescale, 
	tint = particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	premul_alpha = particle_premul_alpha
}
if particle_shadows then--particle_r > 0 and particle_g > 0 and particle_b > 0 then
	data.raw["optimized-particle"]["blood-particle-carpet-small"].shadows = gore_blood_particle_shadow{scale = 1*settings.startup["gore-particlescale"].value}
else
	data.raw["optimized-particle"]["blood-particle-carpet-small"].shadows = nil
end

data.raw["optimized-particle"]["blood-particle-carpet"].pictures = gore_blood_particle{
	preset = preset,
	scale = particlescale, 
	tint = particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	premul_alpha = particle_premul_alpha
}

if particle_shadows then--particle_r > 0 and particle_g > 0 and particle_b > 0 then
	data.raw["optimized-particle"]["blood-particle-carpet"].shadows = gore_blood_particle_shadow{scale = 1*settings.startup["gore-particlescale"].value}
else
	data.raw["optimized-particle"]["blood-particle-carpet"].shadows = nil
end

data.raw["optimized-particle"]["blood-particle-lower-layer-small"].pictures = gore_blood_particle{
	preset = preset,
	scale = particlescale, 
	tint = particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	premul_alpha = particle_premul_alpha
}

if settings.startup["gore-change_guts"].value then
	data.raw["optimized-particle"]["guts-entrails-particle-small-medium"].pictures = gore_guts_particle{
		preset = preset,
		scale = 0.17*0.9, 
		tint = guts_tint or particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	}
	data.raw["optimized-particle"]["guts-entrails-particle-big"].pictures = gore_guts_particle{
		preset = preset,
		scale = 0.35*0.9, 
		tint = guts_tint or particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	}
	data.raw["optimized-particle"]["guts-entrails-particle-spawner"].pictures = gore_guts_particle{
		preset = preset,
		scale = 0.5*0.9, 
		tint = guts_tint or particle_color,--{r=particle_r,g=particle_g,b=particle_b,a=particle_a,blend_mode = blender},
	}
end


--for key, tbl in pairs(data.raw.particle["blood-particle"].pictures) do
--tbl.filename = "__gore__/graphics/blood-particle/"..preset.."blood-particle-"..key..".png"
--tbl.width = tbl.width*2
--tbl.height = tbl.height*2
--tbl.scale = 1*settings.startup["gore-particlescale"].value
--tbl.blend_mode = blender
--tbl.tint = {r=0,g=0,b=0,a=0}  --{r=0.3,g=0,b=0.01,a=0.3}
--tbl.tint.r = particle_r
--tbl.tint.g = particle_g
--tbl.tint.b = particle_b
--tbl.tint.a = particle_a
--tbl.hr_version = nil
--end
data.raw["optimized-particle"]["blood-particle"].life_time = 60*20
data.raw["optimized-particle"]["blood-particle"].life_time = 30
--if not settings.startup["gore-custom_decals"].value then
	data.raw["optimized-particle"]["blood-particle"].life_time = math.max(1,settings.startup["gore-puddleduration"].value*60+60)
--end

--data.raw["explosion"]["blood-explosion-small"].created_effect.action_delivery.target_effects.repeat_count =  40--math.floor(data.raw["explosion"]["blood-explosion-small"].created_effect.action_delivery.target_effects.repeat_count * 0.5)
--data.raw["explosion"]["blood-explosion-big"].created_effect.action_delivery.target_effects[2].repeat_count = 40--math.floor(data.raw["explosion"]["blood-explosion-big"].created_effect.action_delivery.target_effects[2].repeat_count * 0.5)
--data.raw["particle-source"]["blood-fountain"].horizontal_speed_deviation = 0.0001
--data.raw["particle-source"]["blood-fountain"].vertical_speed_deviation = 0.0001
--data.raw["particle-source"]["blood-fountain"].horizontal_speed = 0.09
--data.raw["particle-source"]["blood-fountain"].time_to_live_deviation = 5
--data.raw["particle-source"]["blood-fountain"].time_to_live_deviation = 3
--data.raw["particle-source"]["blood-fountain"].time_to_live = 20
--data.raw["particle-source"]["blood-fountain"].time_before_start_deviation = 2
--data.raw["explosion"]["blood-explosion-huge"]



bigparticle = table.deepcopy(data.raw["optimized-particle"]["blood-particle"])
bigparticle.name = "big-blood-particle"
bigparticle.life_time = math.max(1,settings.startup["gore-particleduration"].value*60)					--duration how long bullet impact particles stay on the floor
bigparticle.render_layer = "decorative"

--for key, tbl in pairs(bigparticle.pictures) do
bigparticle.pictures.sheet.blend_mode = blender
bigparticle.pictures.sheet.render_layer = "decorative"
bigparticle.pictures.sheet.tint = particle_color
--end

if bigparticle.shadows then
	for _, tbl in pairs(bigparticle.shadows) do
		tbl.scale = 0.01
	end
end

bigfountain = table.deepcopy(data.raw["particle-source"]["blood-fountain"])
bigfountain.name = "big-blood-fountain"
bigfountain.flags = flagger
bigfountain.particle = "big-blood-particle"
bigfountain.vertical_speed = 0.05
bigfountain.vertical_speed_deviation = 0.035
bigfountain.horizontal_speed = 0.035
bigfountain.horizontal_speed_deviation = 0.015
bigfountain.height_deviation = 0.15
bigfountain.time_to_live = 5
bigfountain.time_to_live_deviation = 2
bigfountain.render_layer = "decorative"

data:extend({
	  bigparticle,
	  bigfountain
	})

local planet = ""
local function all_prototypes()
	data:extend({
	{
		type = "smoke-with-trigger",
		name = planet.."blood1",
		flags = flagger,
		render_layer = "item-in-inserter-hand",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/"..preset.."blood1.png",
			priority = "low",
			width = 170,
			height = 120,
			frame_count = 8,
			animation_speed = 0.3,
			line_length = 4,
			scale = 0.9*scaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			shift = shifter,
			tint = fx_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 28,
		fade_away_duration = 13,
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."blood2",
		flags = flagger,
		render_layer = "item-in-inserter-hand",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/"..preset.."blood2-hr.png",
			priority = "low",
			width = 640,
			height = 1000,
			frame_count = 6,
			animation_speed = 0.22,
			line_length = 3,
			scale = 0.32*scaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			shift = {shifter[1],shifter[2]+0.12},
			tint = fx_color,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 29,
		fade_away_duration = 13,
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."blood3",
		flags = flagger,
		render_layer = "item-in-inserter-hand",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/"..preset.."blood3-hr.png",
			priority = "low",
			width = 512,
			height = 512,
			frame_count = 6,
			animation_speed = 0.18,
			line_length = 6,
			scale = 0.38*scaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			shift = shifter,
			tint = fx_color,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 35,
		fade_away_duration = 15,
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."blood4",
		flags = flagger,
		render_layer = "item-in-inserter-hand",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/"..preset.."blood4-hr.png",
			priority = "low",
			width = 512,
			height = 512,
			frame_count = 6,
			animation_speed = 0.18,
			line_length = 3,
			scale = 0.38*scaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			shift = shifter,
			tint = fx_color,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 35,
		fade_away_duration = 15,
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."blood5",
		flags = flagger,
		render_layer = "item-in-inserter-hand",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/"..preset.."blood5-hr.png",
			priority = "low",
			width = 512,
			height = 512,
			frame_count = 6,
			animation_speed = 0.18,
			line_length = 3,
			scale = 0.38*scaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			shift = shifter,
			tint = fx_color,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 35,
		fade_away_duration = 15,
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."blood7",
		flags = flagger,
		render_layer = "item-in-inserter-hand",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/"..preset.."blood7.png",
			priority = "low",
			width = 230,
			height = 240,
			frame_count = 4,
			animation_speed = 0.29,
			line_length = 4,
			scale = 0.8*scaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			shift = {shifter[1],shifter[2]+0.15},
			tint = fx_color,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 15,
		fade_away_duration = 8,
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."blood6",
		flags = flagger,
		render_layer = "item-in-inserter-hand",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/"..preset.."blood6.png",
			priority = "low",
			width = 128,
			height = 128,
			frame_count = 7,
			animation_speed = 0.3,
			line_length = 4,
			scale = 1*scaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			shift = shifter,
			tint = fx_color,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 26,
		fade_away_duration = 11,
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."splatter1",
		flags = flagger,
		render_layer = "decorative",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/splatter/"..preset.."splatter1b.png",
			priority = "low",
			width = 1778,
			height = 1461,
			frame_count = 1,
			animation_speed = 0.3,
			line_length = 1,
			scale = 0.09*splatterscaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			--shift = {0.5,0.5},
			tint = decal_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = splatterduration,
		fade_away_duration = math.min(splatterduration/2,600),
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."splatter2",
		flags = flagger,
		render_layer = "decorative",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/splatter/"..preset.."splatter2b.png",
			priority = "low",
			width = 1657,
			height = 1360,
			frame_count = 1,
			animation_speed = 0.3,
			line_length = 1,
			scale = 0.1*splatterscaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			--shift = {0.5,0.5},
			tint = decal_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = splatterduration,
		fade_away_duration = math.min(splatterduration/2,600),
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."splatter3",
		flags = flagger,
		render_layer = "decorative",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/splatter/"..preset.."splatter3b.png",
			priority = "low",
			width = 2048,
			height = 1536,
			frame_count = 1,
			animation_speed = 0.3,
			line_length = 1,
			scale = 0.12*splatterscaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			--shift = {0.5,0.5},
			tint = decal_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = splatterduration,
		fade_away_duration = math.min(splatterduration/2,600),
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."splatter4",
		flags = flagger,
		render_layer = "decorative",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/splatter/"..preset.."splatter4b.png",
			priority = "low",
			width = 1831,
			height = 1498,
			frame_count = 1,
			animation_speed = 0.3,
			line_length = 1,
			scale = 0.08*splatterscaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			--shift = {0.5,0.5},
			tint = decal_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = splatterduration,
		fade_away_duration = math.min(splatterduration/2,600),
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."splatter5",
		flags = flagger,
		render_layer = "decorative",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/splatter/"..preset.."splatter5b.png",
			priority = "low",
			width = 2048,
			height = 1536,
			frame_count = 1,
			animation_speed = 0.3,
			line_length = 1,
			scale = 0.12*splatterscaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			--shift = {0.5,0.5},
			tint = decal_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = splatterduration,
		fade_away_duration = math.min(splatterduration/2,600),
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."splatter6",
		flags = flagger,
		render_layer = "decorative",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/splatter/"..preset.."splatter6b.png",
			priority = "low",
			width = 510,
			height = 512,
			frame_count = 1,
			animation_speed = 0.3,
			line_length = 1,
			scale = 0.25*splatterscaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			--shift = {0.5,0.5},
			tint = decal_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = splatterduration,
		fade_away_duration = math.min(splatterduration/2,600),
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	},
	{
		type = "smoke-with-trigger",
		name = planet.."splatter7",
		flags = flagger,
		render_layer = "decorative",
		show_when_smoke_off = true,
		animation =
		{
			filename = "__gore__/graphics/splatter/"..preset.."splatter7b.png",
			priority = "low",
			width = 510,
			height = 512,
			frame_count = 1,
			animation_speed = 0.3,
			line_length = 1,
			scale = 0.25*splatterscaler,
			blend_mode = blender,
			apply_runtime_tint=true,
			--shift = {0.5,0.5},
			tint = decal_color
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = splatterduration,
		fade_away_duration = math.min(splatterduration/2,600),
		spread_duration = 0,
		movement_slow_down_factor = 0,
		color = { r = 1, g = 1, b = 1},
		
		action_cooldown = 30
	}
})
end
all_prototypes()
----------------------						----------------------						----------------------						--corpse updates

for i=-1,34 do
	local explo = table.deepcopy(data.raw.explosion["blood-explosion-small"])
	explo.name = "blood-explosion-"..i
	explo.created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "create-entity",
          entity_name = "blood-fountain",
          repeat_count = 1+i,
          offset_deviation = {{-0.4, -0.4}, {0.4, 0.4}}
        }
      }
    }
	data:extend({explo})
end

for _,explo in pairs(data.raw.explosion) do
	if explo.created_effect and explo.created_effect.action_delivery and explo.created_effect.action_delivery.target_effects then
		for _,effect in pairs(explo.created_effect.action_delivery.target_effects) do
			if type(effect) == "table" and effect.particle_name and effect.particle_name:find("guts") then
				effect.repeat_count = math.floor(effect.repeat_count*settings.startup["gore-guts_mult"].value)
				effect.repeat_count_deviation = math.floor(effect.repeat_count_deviation*settings.startup["gore-guts_mult"].value)
			end
		end
	end
end


if mods["space-age"] then
	planet = "gleba-"
	fx_color = {r=0.69, g=0.45, b=0.18, a=1}
	decal_color = fx_color
	particle_color = fx_color
	guts_tint = nil
	preset = ""
	local tint_mult = 1/fx_color.r
	tint_mult = math.min(tint_mult,1/fx_color.g)
	tint_mult = math.min(tint_mult,1/fx_color.b)
	corpse_tint = {r = fx_color.r*tint_mult*0.9, g = fx_color.g*tint_mult*0.9, b = fx_color.b*tint_mult*0.9, a = 1}
	all_prototypes()
	
	data.raw["unit-spawner"]["gleba-spawner"].dying_explosion = "medium-wriggler-die"
	data.raw["unit-spawner"]["gleba-spawner-small"].dying_explosion = "small-wriggler-die"
	for a,b in pairs(data.raw.projectile) do
		if a:sub(-18) == "strafer-projectile" then
			if b.action.action_delivery.target_effects[3].action.action_delivery.target_effects[4].entity_name then
				b.action.action_delivery.target_effects[3].action.action_delivery.target_effects[4].entity_name = "small-wriggler-die"
			end
		end
	end
end
if mods["ArmouredBiters"] then
	if not settings.startup["gore-armoured_bleed"].value ~= "all" then
		local armoured_units = {
		"small-armoured-biter",
		"medium-armoured-biter",
		"big-armoured-biter",
		"behemoth-armoured-biter",
		"leviathan-armoured-biter"
		}
		
		for _, u in pairs(armoured_units) do
			if data.raw.unit[u] then
				data.raw.unit[u].dying_explosion = nil
				data.raw.unit[u].damaged_trigger_effect = nil
			end
		end
	end
end