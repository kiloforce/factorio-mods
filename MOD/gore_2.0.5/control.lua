
local splashes = settings.startup["gore-custom_splashes"].value
local decals = settings.startup["gore-custom_decals"].value

script.on_event(defines.events.on_entity_died, function(event)
	local entity = event.entity
	if not entity.has_flag("breaths-air") or entity.type == "tree" then return end
	local prefix = ""
	local surface = event.entity.surface.name
	if surface == "vulcanus" then
		return
	end
	local entity_name = event.entity.name
	if surface == "gleba" and entity_name ~= "character" then
		prefix = "gleba-"
	end
	if not entity.name:find("armoured--biter") or settings.startup["gore-armoured_bleed"].value == "all" then
		if splashes then
			local rnd = math.floor(math.random()*6.1+1.5)
			entity.surface.create_entity({
						name=prefix.."blood"..rnd,
						position=entity.position})
		end
	end
	if not entity.name:find("armoured--biter") or settings.startup["gore-armoured_bleed"].value ~= "none" then
		if decals then
			local rnd = math.floor(math.random()*6.99+1)
			entity.surface.create_entity({
						name=prefix.."splatter"..rnd,
						position=entity.position})
		end
	end
end)

if settings.startup["gore-damage-bleeding"].value then
	script.on_event(defines.events.on_entity_damaged, function(event)
		if not event.entity.has_flag("breaths-air") then return end
		local surface = event.entity.surface.name
		local entity_name = event.entity.name
		if (surface == "gleba" or surface == "vulcanus") and entity_name ~="character" then return end
		local max_health = event.entity.prototype.get_max_health(event.entity.quality)
		if event.final_damage_amount > max_health/250 then
			local damage_type_name = event.damage_type.name
			if(damage_type_name == "physical" ) then-- or damage_type_name == "laser") then
				if not event.entity.name:find("armoured--biter") or settings.startup["gore-armoured_bleed"].value == "all" then
					local blood_count = math.floor(math.max(0,math.min(34,math.min(math.log(max_health, 4)*4,event.final_damage_amount/max_health*20)+math.random())))
					if (math.random()+0.34)*(blood_count/3+1) > 1.2 or entity_name =="character" then
						--game.print(game.tick.." "..blood_count)
						--if damage_type_name == "physical" then
							event.entity.surface.create_entity({
								name="blood-explosion-"..blood_count,
								position=event.entity.position
							})
					end
				else
					if math.random()/4/(3*(1-event.entity.health/max_health))< event.final_damage_amount/max_health then
						--game.print(game.tick.." "..blood_count)
						--if damage_type_name == "physical" then
							event.entity.surface.create_entity({
								name="blood-explosion-".. 1,
								position={event.entity.position.x-0.4+math.random()*0.8,event.entity.position.y+1}
							})
					end
				end			
					--else
					--	event.entity.surface.create_entity({
					--		name="blood-explosion-0",
					--		position=event.entity.position
					--	})  
					--end
			end
		end
	end)
	script.set_event_filter(defines.events.on_entity_damaged, {{filter = "type", type = "unit"},{filter = "type", type = "character"}})
end