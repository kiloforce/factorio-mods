require("load_settings")
require("bloodparticle")

local tinter = decal_color
tinter.a=1



 local a = 1
 local d = puddle_d
 

files = {
"__base__/graphics/entity/biter/biter-die-1.png",
"__base__/graphics/entity/biter/biter-die-2.png",
"__base__/graphics/entity/biter/biter-die-3.png",
"__base__/graphics/entity/biter/biter-die-4.png",
"__base__/graphics/entity/spitter/spitter-die-1.png",
"__base__/graphics/entity/spitter/spitter-die-2.png",
"__base__/graphics/entity/spitter/spitter-die-3.png",
"__base__/graphics/entity/spitter/spitter-die-4.png",
"__base__/graphics/entity/worm/worm-die-01.png",
"__base__/graphics/entity/worm/worm-die-02.png",
"__base__/graphics/entity/worm/worm-die-03.png",
"__base__/graphics/entity/biter/biter-decay-1.png",
"__base__/graphics/entity/biter/biter-decay-2.png",
"__base__/graphics/entity/biter/biter-decay-3.png",
"__base__/graphics/entity/biter/biter-decay-4.png",
"__base__/graphics/entity/biter/biter-decay-5.png",
"__base__/graphics/entity/biter/biter-decay-6.png",
"__base__/graphics/entity/spitter/spitter-decay-1.png",
"__base__/graphics/entity/spitter/spitter-decay-2.png",
"__base__/graphics/entity/spitter/spitter-decay-3.png",
"__base__/graphics/entity/spitter/spitter-decay-4.png",
"__base__/graphics/entity/spitter/spitter-decay-5.png",
"__base__/graphics/entity/worm/worm-decay-01.png",
"__base__/graphics/entity/worm/worm-decay-02.png",
"__base__/graphics/entity/worm/worm-decay-03.png",
}
local function table_find (t,v)
for a,b in pairs(t) do
	if b==v then
		return a
	end
end
return nil
end

for key, tbl in pairs (data.raw.corpse) do
	if tbl.animation and tbl.animation.layers and tbl.animation.layers[2] and tbl.animation.layers[1].filenames then
		local found = nil
		for a,b in pairs(tbl.animation.layers[1].filenames) do
			if table_find(files, b) then
				if preset == "red-" then
					local slash = b:reverse():find("/")
					tbl.animation.layers[1].filenames[a] = "__gore__/graphics/red-corpse"..b:sub(-slash)
					tbl.time_before_removed = settings.startup["gore-bodyduration"].value*60
				else
					found = table.deepcopy(tbl.animation.layers[1])
				end
			end
		end
		if found then
			table.insert(tbl.animation.layers,2,found)
			for a,b in pairs(tbl.animation.layers[2].filenames) do
				if table_find(files, b) then
					local slash = b:reverse():find("/")
					tbl.animation.layers[2].filenames[a] = "__gore__/graphics/corpse"..b:sub(-slash)
					tbl.animation.layers[2].tint = corpse_tint
				end
			end
		end
	elseif tbl.animation and tbl.animation[2] then
		for a,b in pairs(tbl.animation) do
			local found = nil
			if b.layers and b.layers[1] and b.layers[1].filename and table_find(files,b.layers[1].filename) then
				if preset == "red-" then
					local slash = b.layers[1].filename:reverse():find("/")
					b.layers[1].filename = "__gore__/graphics/red-corpse"..b.layers[1].filename:sub(-slash)
					tbl.time_before_removed = settings.startup["gore-bodyduration"].value*60
				else
					found = table.deepcopy(b.layers[1])
				end
			end
			if found then
				table.insert(b.layers,2,found)
				local slash = b.layers[2].filename:reverse():find("/")
				b.layers[2].filename = "__gore__/graphics/corpse"..b.layers[2].filename:sub(-slash)
				b.layers[2].tint = corpse_tint
			end
		end
	end
	if tbl.decay_animation and tbl.decay_animation.layers and tbl.decay_animation.layers[2] and tbl.decay_animation.layers[1].filenames and tbl.decay_animation.layers[1].filenames then
		local found = nil
		for a,b in pairs(tbl.decay_animation.layers[1].filenames) do
			if table_find(files, b) then
				if preset == "red-" then
					local slash = b:reverse():find("/")
					tbl.decay_animation.layers[1].filenames[a] = "__gore__/graphics/red-corpse"..b:sub(-slash)
					tbl.time_before_removed = settings.startup["gore-bodyduration"].value*60
				else
					found = table.deepcopy(tbl.decay_animation.layers[1])
				end
			end
		end
		if found then
			table.insert(tbl.decay_animation.layers,2,found)
			for a,b in pairs(tbl.decay_animation.layers[2].filenames) do
				if table_find(files, b) then
					local slash = b:reverse():find("/")
					tbl.decay_animation.layers[2].filenames[a] = "__gore__/graphics/corpse"..b:sub(-slash)
					tbl.decay_animation.layers[2].tint = corpse_tint
				end
			end
		end
	elseif tbl.decay_animation and tbl.decay_animation[2] then
		for a,b in pairs(tbl.decay_animation) do
			local found = nil
			if b.layers and b.layers[1] and b.layers[1].filename and table_find(files,b.layers[1].filename) then
				if preset == "red-" then
					local slash = b.layers[1].filename:reverse():find("/")
					b.layers[1].filename = "__gore__/graphics/red-corpse"..b.layers[1].filename:sub(-slash)
					tbl.time_before_removed = settings.startup["gore-bodyduration"].value*60
				else
					found = table.deepcopy(b.layers[1])
				end
			end
			if found then
				table.insert(b.layers,2,found)
				local slash = b.layers[2].filename:reverse():find("/")
				b.layers[2].filename = "__gore__/graphics/corpse"..b.layers[2].filename:sub(-slash)
				b.layers[2].tint = corpse_tint
			end
		end
	end
	if settings.startup["gore-hide_puddle"].value then
		tbl.ground_patch = nil
	elseif tbl.ground_patch and tbl.ground_patch.sheet and tbl.ground_patch.sheet.filename and tbl.ground_patch.sheet.filename:find("puddle") or tbl.ground_patch and tbl.ground_patch.filename and tbl.ground_patch.filename:find("puddle") then
		if tbl.name:find("walking--electric--unit") then
			tbl.ground_patch = gore_blood_puddle{tint = {r=0,g=0,b=0}, preset = "dense-", scale = 0.85}
			tbl.time_before_removed = settings.startup["gore-bodyduration"].value*60 --15*60*60
			tbl.ground_patch_fade_out_start=settings.startup["gore-puddleduration"].value*60
			tbl.ground_patch_fade_in_speed=0.0005
		elseif tbl.name:find("armoured--corpse") then
			tbl.ground_patch = gore_blood_puddle{scale = tbl.animation.layers[1].scale*3.3,animation_speed = 0.1}
			tbl.time_before_removed = settings.startup["gore-bodyduration"].value*60 --15*60*60
			tbl.ground_patch_fade_out_start=settings.startup["gore-puddleduration"].value*60
			tbl.ground_patch_fade_in_speed=0.001
			tbl.ground_patch_fade_in_delay=30 --instead of 50 ticks
		elseif not tbl.name:find("pentapod") then
			tbl.ground_patch = gore_blood_puddle{}
			tbl.time_before_removed = settings.startup["gore-bodyduration"].value*60 --15*60*60
			tbl.ground_patch_fade_out_start=settings.startup["gore-puddleduration"].value*60
		end
	end
end



