



script.on_init(function()
	storage.version = 1
	storage.shields = {}
end)


--script.on_configuration_changed(function()
--	
--end)
function print(str)
game.players[1].print(str)
end



--script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
--	alternate_effect = settings.storage["SFX_alternate_effect"].value
--end)

function projection ( orientation, distance, position)
if not position then position = {x=0,y=0} end
if not distance then distance = 0 end
local temp_x = math.sin((orientation+0)*2*math.pi)*distance
local temp_y =  math.sin((orientation+0.75)*2*math.pi)*distance
return{x=temp_x+position.x, y = temp_y+position.y}
end

script.on_event(defines.events.on_entity_damaged or 97,function(event)
	if event.final_damage_amount >0 then return end
	if event.entity.type == "character"
	or event.entity.type == "car" 
	or event.entity.type == "spider-vehicle" then
		if not event.entity.grid then return end
		if event.entity.grid.shield <0.1 then return end
		if event.entity.grid.shield ==event.entity.grid.max_shield then return end
		
		local damage=event.final_damage_amount
		
		local shieldamount
		local max_shield = 200
		shieldamount = event.entity.grid.shield --200 --storage.shields[event.entity.unit_number][7].energy / storage.shields[event.entity.unit_number][7].electric_buffer_size * max_shield
		local min_shield = 3.4 + math.min(max_shield,200)/70
		if alternate_effect then
			min_shield = 2 + math.min(max_shield, 200)/15
		end
		
		if event.entity.health > 0 and ((shieldamount > min_shield and shieldamount > damage/2) or shieldamount > damage) then
	
			
				
				--if storage.shields[event.entity.unit_number] and storage.shields[event.entity.unit_number][2].valid then storage.shields[event.entity.unit_number][2].destroy() end
	
	
			local surface = event.entity.surface
			--local position = event.entity.position
			local position = projection(event.entity.orientation, event.entity.speed, event.entity.position)
			local effect = ""
			if string.find(event.entity.name,"tank") or event.entity.type == "spider-vehicle" then
				effect = effect.."-big"
			end
			
			
	
			--if event.entity.name == "laser-turret" then
			--	position.y = position.y -0.16
			--	position.x = position.x +0.02					
			--end

			if not storage.shields[event.entity.unit_number] then
				storage.shields[event.entity.unit_number] = {event.entity}
			end
			if settings.global["SFX_alternate_effect"].value then
				if storage.shields[event.entity.unit_number][3] == nil or storage.shields[event.entity.unit_number][3] < game.tick-5 then
					if storage.shields[event.entity.unit_number][2] ~= nil and storage.shields[event.entity.unit_number][2].valid then
						effect = effect.."2"
						storage.shields[event.entity.unit_number][2].destroy()
					end
					if event.entity.type == "car" then
						if string.find(event.entity.name,"tank") then
							position.y = position.y - 0.4
							position.x = position.x - 0.16
						end
						position.y = position.y + 0.42
					elseif event.entity.type == "spider-vehicle" then
						position.y = position.y - 1.1
					else
						position.y = position.y - 0.2
					end
					storage.shields[event.entity.unit_number][2] = surface.create_entity{name = "shield-effect-alternate"..effect, position = {position.x-0.06, position.y -0.5}, force = "neutral"}
					storage.shields[event.entity.unit_number][3] = game.tick
				end
			else
				--for i=1, math.max(1,absorbed/20) do
					storage.shields[event.entity.unit_number][4] = position
					storage.shields[event.entity.unit_number][3] = game.tick
					if event.entity.type == "car" then
						position.y = position.y + 0.3
						if effect == "-big" then
							position.y = position.y -0.31
							position.x = position.x -0.2
						end
					elseif event.entity.type == "spider-vehicle" then
						position.y = position.y - 1.1
					else
						position.y = position.y - 0.2
					end
					
					surface.create_trivial_smoke{name="shield-effect"..effect, position = {position.x, position.y -0.48}}
					surface.create_trivial_smoke{name="shield-effect"..effect, position = {position.x, position.y -0.48}}
				--end
			end

		end
		
	end
end)
script.set_event_filter(defines.events.on_entity_damaged, {{filter = "vehicle"},{filter = "type", type = "character"}})

function b2s(bool)
if bool then return "true" else return "false" end
end

script.on_nth_tick(1, function(event)
	for key, tbl in pairs(storage.shields) do
		if tbl[1].valid and tbl[2] and tbl[2].valid then
			local pos = projection(tbl[1].orientation, tbl[1].speed, tbl[1].position)
			if tbl[1].type == "car" then
				if string.find(tbl[1].name,"tank") then
					tbl[2].teleport({pos.x-0.22,pos.y-0.48})
				else
					tbl[2].teleport({pos.x-0.06,pos.y-0.08})
				end
			elseif tbl[1].type == "spider-vehicle" then
				tbl[2].teleport({pos.x,pos.y-1.58})
			else
				tbl[2].teleport({pos.x-0.06,pos.y-0.7})
			end
		elseif tbl[1].valid and not settings.global["SFX_alternate_effect"].value and tbl[4] ~=pos and tbl[3] >event.tick -7 then
			local pos = projection(tbl[1].orientation, tbl[1].speed, tbl[1].position)
			if tbl[1].type == "car" then
				if string.find(tbl[1].name,"tank") then
					tbl[1].surface.create_trivial_smoke{name="shield-effect-big", position = {pos.x-0.2, pos.y -0.5}}
				else
					tbl[1].surface.create_trivial_smoke{name="shield-effect", position = {pos.x, pos.y -0.18}}
				end
			elseif tbl[1].type == "spider-vehicle" then
				tbl[1].surface.create_trivial_smoke{name="shield-effect-big", position = {pos.x, pos.y -1.7}}
			else
				tbl[1].surface.create_trivial_smoke{name="shield-effect", position = {pos.x, pos.y -0.8}}
			end
		else
			storage.shields[key]=nil
		end
	end
end)


script.on_event({defines.events.on_entity_died,defines.events.on_player_mined_entity,defines.events.on_robot_mined_entity},function(event)
		if (event.entity.type == "player"
		or event.entity.type == "car")
		and storage.shields[event.entity] then
			storage.shields[event.entity] = nil
	end
end)

--storage.shields[entity.unit_number]
-- 1	car / player entity
-- 2	shield
-- 3	alternate shield last update