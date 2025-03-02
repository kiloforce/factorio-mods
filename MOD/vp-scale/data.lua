-- Space location names in this list will not have its scale changed by their gravity.
local planet_scale_blacklist = {
}

---Add a list of planet names to the scale blacklist
---@param names table<string> list of planets internal names (PlanetPrototype.name) 
function vp_scale_add_planets_to_scale_blacklist(names)
    for _, name in pairs(names) do
        planet_scale_blacklist[name] = true
    end
end

---Get the scale blacklist table
---@return table<string, boolean>
function vp_scale_get_planet_scale_blacklist()
	return planet_scale_blacklist
end
