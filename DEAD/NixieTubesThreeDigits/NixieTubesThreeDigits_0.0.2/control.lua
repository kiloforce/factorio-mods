do
    -- don't load if sim scenario has already loaded this (in another lua state)
    local modloader = remote.interfaces["modloader"]
    if modloader and modloader[script.mod_name] then
        return
    end
end

---@class NixieGlobal
---@field alphas {[integer]:LuaEntity?}
---@field next_alpha? integer
---@field controllers {[integer]:LuaEntity?}
---@field next_controller? integer
---@field nextdigit {[integer]:LuaEntity?}
---@field cache {[integer]:NixieCache?}
global = {}

---@class NixieCache
---@field control? LuaLampControlBehavior
---@field lastvalue? integer
---@field lastcolor Color[]
---@field sprites integer[] rendering sprite IDs

---@param unit_number integer
---@return NixieCache
local function getCache(unit_number)
    local cache = global.cache[unit_number]
    if not cache then
        cache = {
            lastcolor = {},
            sprites = {}
        }
        global.cache[unit_number] = cache
    end
    return cache
end

local validEntityName = {
    ['nixie-tube'] = 1,
    ['nixie-tube-alpha'] = 1,
    ['nixie-tube-small'] = 2,
    ['nixie-tube-triplet'] = 3
}

local signalCharMap = {
    ["signal-0"] = "0",
    ["signal-1"] = "1",
    ["signal-2"] = "2",
    ["signal-3"] = "3",
    ["signal-4"] = "4",
    ["signal-5"] = "5",
    ["signal-6"] = "6",
    ["signal-7"] = "7",
    ["signal-8"] = "8",
    ["signal-9"] = "9",
    ["signal-A"] = "A",
    ["signal-B"] = "B",
    ["signal-C"] = "C",
    ["signal-D"] = "D",
    ["signal-E"] = "E",
    ["signal-F"] = "F",
    ["signal-G"] = "G",
    ["signal-H"] = "H",
    ["signal-I"] = "I",
    ["signal-J"] = "J",
    ["signal-K"] = "K",
    ["signal-L"] = "L",
    ["signal-M"] = "M",
    ["signal-N"] = "N",
    ["signal-O"] = "O",
    ["signal-P"] = "P",
    ["signal-Q"] = "Q",
    ["signal-R"] = "R",
    ["signal-S"] = "S",
    ["signal-T"] = "T",
    ["signal-U"] = "U",
    ["signal-V"] = "V",
    ["signal-W"] = "W",
    ["signal-X"] = "X",
    ["signal-Y"] = "Y",
    ["signal-Z"] = "Z",
    ["signal-negative"] = "negative",

    -- extended symbols
    ["signal-stop"] = "dot",
    ["signal-qmark"] = "?",
    ["signal-exmark"] = "!",
    ["signal-at"] = "@",
    ["signal-sqopen"] = "[",
    ["signal-sqclose"] = "]",
    ["signal-curopen"] = "{",
    ["signal-curclose"] = "}",
    ["signal-paropen"] = "(",
    ["signal-parclose"] = ")",
    ["signal-slash"] = "slash",
    ["signal-asterisk"] = "*",
    ["signal-minus"] = "-",
    ["signal-plus"] = "+",
    ["signal-percent"] = "%"
}

local function RegisterStrings()
    if remote.interfaces['signalstrings'] and remote.interfaces['signalstrings']['register_signal'] then
        local syms = {
            ["signal-stop"] = ".",
            ["signal-qmark"] = "?",
            ["signal-exmark"] = "!",
            ["signal-at"] = "@",
            ["signal-sqopen"] = "[",
            ["signal-sqclose"] = "]",
            ["signal-curopen"] = "{",
            ["signal-curclose"] = "}",
            ["signal-paropen"] = "(",
            ["signal-parclose"] = ")",
            ["signal-slash"] = "/",
            ["signal-asterisk"] = "*",
            ["signal-minus"] = "-",
            ["signal-plus"] = "+",
            ["signal-percent"] = "%"
        }
        for name, char in pairs(syms) do
            remote.call('signalstrings', 'register_signal', name, char)
        end
    end
end

-- sets the state(s) and update the sprite for a nixie
local is_simulation = script.level.is_simulation

---@param nixie LuaEntity
---@param cache NixieCache
---@param newstates string[]
---@param newcolor? Color
local function setStates(nixie, cache, newstates, newcolor)
    for key, new_state in pairs(newstates) do
        if not new_state then
            new_state = "off"
        end
        -- printing floats sometimes hands us a literal '.', needs to be renamed
        if new_state == '.' then
            new_state = "dot"
        end

        local obj = cache.sprites[key]
        if not (obj and rendering.is_valid(obj)) then
            -- if 1+1==2 then
            cache.lastcolor[key] = nil

            local num = validEntityName[nixie.name]
            ---@type Vector.0
            local position
            if num == 1 then -- large tube, one sprite
                position = {
                    x = 1 / 32,
                    y = 1 / 32
                }
            elseif num == 2 then
                position = {
                    x = -9 / 64 + ((key - 1) * 20 / 64),
                    y = 3 / 64
                } -- sprite offset
            elseif num == 3 then
                position = {
                    x = -35 / 64 + ((key - 1) * 36 / 64),
                    y = 2.5 / 64
                } -- sprite offset
            end
            if num < 3 then
                obj = rendering.draw_sprite {
                    sprite = "nixie-tube-sprite-" .. new_state,
                    target = nixie,
                    target_offset = position,
                    surface = nixie.surface,
                    tint = {
                        r = 1.0,
                        g = 1.0,
                        b = 1.0,
                        a = 1.0
                    },
                    x_scale = 1 / num,
                    y_scale = 1 / num,
                    render_layer = "object"
                }
            elseif num == 3 then
                obj = rendering.draw_sprite {
                    sprite = "nixie-tube-sprite-" .. new_state,
                    target = nixie,
                    target_offset = position,
                    surface = nixie.surface,
                    tint = {
                        r = 1.0,
                        g = 1.0,
                        b = 1.0,
                        a = 1.0
                    },
                    x_scale = 0.9,
                    y_scale = 1 / 2,
                    render_layer = "object"
                }
            end

            cache.sprites[key] = obj
        end

        if nixie.energy > 70 or is_simulation then
            rendering.set_sprite(obj, "nixie-tube-sprite-" .. new_state)

            local color = newcolor
            if not color then
                color = {
                    r = 1.0,
                    g = 0.6,
                    b = 0.2,
                    a = 1.0
                }
            end
            if new_state == "off" then
                color = {
                    r = 1.0,
                    g = 1.0,
                    b = 1.0,
                    a = 1.0
                }
            end

            if not (cache.lastcolor[key] and (cache.lastcolor[key].r == color.r) and (cache.lastcolor[key].g == color.g) and
                (cache.lastcolor[key].b == color.b) and (cache.lastcolor[key].a == color.a)) then
                cache.lastcolor[key] = color
                rendering.set_color(obj, color)
            end
        else
            if rendering.get_sprite(obj) ~= "nixie-tube-sprite-off" then
                rendering.set_sprite(obj, "nixie-tube-sprite-off")
            end
            rendering.set_color(obj, {
                r = 1.0,
                g = 1.0,
                b = 1.0,
                a = 1.0
            })
            cache.lastcolor[key] = nil
        end
    end
end

---@param behavior LuaLampControlBehavior
---@return SignalID?
local function get_selected_signal(behavior)
    if behavior == nil then
        return nil
    end

    local condition = behavior.circuit_condition
    if condition == nil then
        return nil
    end

    local signal = condition.condition.first_signal
    if signal and not condition.fulfilled then
        -- use >= MININT32 to ensure always-on
        condition.condition.comparator = "≥"
        condition.condition.constant = -0x80000000
        condition.condition.second_signal = nil
        behavior.circuit_condition = condition
    end

    return signal
end

---@param filters {[any]:SignalID?}
---@param entity LuaEntity
---@return {[any]:integer?}
local function get_signals_filtered(filters, entity)
    local red = entity.get_circuit_network(defines.wire_type.red)
    local green = entity.get_circuit_network(defines.wire_type.green)
    ---@type {[any]:integer}
    local results = {}
    if not red and not green then
        return results
    end
    for i, f in pairs(filters) do
        results[i] = 0
        if f.name then
            if red then
                results[i] = results[i] + red.get_signal(f)
            end
            if green then
                results[i] = results[i] + green.get_signal(f)
            end
        end
    end
    return results
end

---@param entity LuaEntity
---@param vs? string
---@param color? Color
local function displayValString(entity, vs, color)
    local stringLenght = vs and #vs or 0
    while entity do
        local nextdigit = global.nextdigit[entity.unit_number]
        local cache = getCache(entity.unit_number)
        local digits = #cache.sprites



        if (digits < 3) then
					if not vs then
						if digits == 1 then
							setStates(entity,cache,{"off"})
						else
							setStates(entity,cache,{"off","off"})
						end
					elseif stringLenght < digits then
						setStates(entity,cache,{"off",vs:sub(stringLenght,stringLenght)},color)
					elseif stringLenght >= digits then
						if digits == 1 then
							setStates(entity,cache,{vs:sub(stringLenght,stringLenght)},color)
						else
							setStates(entity,cache,{vs:sub(stringLenght-1,stringLenght-1),vs:sub(stringLenght,stringLenght)},color)
						end        
					end
        elseif (digits == 3) then
            if not vs then
                setStates(entity, cache, {"off", "off", "off"})
            elseif stringLenght == digits - 1 then
                setStates(entity, cache,
                    {"off", vs:sub(stringLenght - 1, stringLenght - 1), vs:sub(stringLenght, stringLenght)}, color)
            elseif stringLenght == digits - 2 then
                setStates(entity, cache, {"off", "off", vs:sub(stringLenght, stringLenght)}, color)
            elseif stringLenght >= digits then
                setStates(entity, cache,
                    {vs:sub(stringLenght - 2, stringLenght - 2), vs:sub(stringLenght - 1, stringLenght - 1),
                     vs:sub(stringLenght, stringLenght)}, color)
            end
        end

        -- if not vs then
        --   setStates(entity,cache,(digits==1) and {"off"} or {"off","off"})
        -- elseif stringLenght < digits then
        --   setStates(entity,cache,{"off",vs:sub(stringLenght,stringLenght)},color)
        -- elseif stringLenght >= digits then
        --   setStates(entity,cache,
        --     (digits==1) and
        --       {vs:sub(stringLenght,stringLenght)} or
        --       {vs:sub(stringLenght-1,stringLenght-1),vs:sub(stringLenght,stringLenght)}
        --     ,color)
        -- end

        if nextdigit then
            if nextdigit.valid then
                if stringLenght > digits then
                    stringLenght = stringLenght - digits
                else
                    vs = nil
                end
            else
                -- when a nixie in the middle is removed, it doesn't have the unit_number to it's right to remove itself
                global.nextdigit[entity.unit_number] = nil
                nextdigit = nil
            end
        end
        ---@diagnostic disable-next-line:cast-local-type
        entity = nextdigit
    end
end

---@param i integer
---@return float
local function float_from_int(i)
    local sign = bit32.btest(i, 0x80000000) and -1 or 1
    local exponent = bit32.rshift(bit32.band(i, 0x7F800000), 23) - 127
    local significand = bit32.band(i, 0x007FFFFF)

    if exponent == 128 then
        if significand == 0 then
            return sign / 0 --[[infinity]]
        else
            return 0 / 0 --[[nan]]
        end
    end

    if exponent == -127 then
        if significand == 0 then
            return sign * 0 --[[zero]]
        else
            return sign * math.ldexp(significand, -149) --[[denormal numbers]]
        end
    end

    return sign * math.ldexp(bit32.bor(significand, 0x00800000), exponent - 23) --[[normal numbers]]
end

---@param entity LuaEntity
---@return string?
local function getAlphaSignals(entity)
    local signals = entity.get_merged_signals()
    ---@type string
    local ch

    if signals and #signals > 0 then
        for _, s in pairs(signals) do
            if signalCharMap[s.signal.name] then
                if ch then
                    return "err"
                else
                    ch = signalCharMap[s.signal.name]
                end
            end
        end
    end

    return ch
end

---@type SignalID
local sigFloat = {
    name = "signal-float",
    type = "virtual"
}

---@type SignalID
local sigHex = {
    name = "signal-hex",
    type = "virtual"
}

---@param entity LuaEntity
---@param cache NixieCache
local function onTickController(entity, cache)
    local control = cache.control
    if not (control and control.valid) then
        control = entity.get_or_create_control_behavior() --[[@as LuaLampControlBehavior]]
        cache.control = control
    end

    local sigdata = get_signals_filtered({
        float = sigFloat,
        hex = sigHex,
        v = get_selected_signal(control)
    }, entity)

    local v = sigdata.v or 0

    if cache.lastvalue ~= v or cache.control.use_colors then
        cache.lastvalue = v

        local float = sigdata.float
        float = float and float ~= 0 ---@diagnostic disable-line:cast-local-type
        local hex = sigdata.hex
        hex = hex and hex ~= 0 ---@diagnostic disable-line:cast-local-type
        local format = "%i"
        if float and hex then
            format = "%A"
            v = float_from_int(v)
        elseif hex then
            format = "%X"
            if v < 0 then
                v = v + 0x100000000
            end
        elseif float then
            format = "%G"
            v = float_from_int(v)
        end

        displayValString(entity, format:format(v), control.use_colors and control.color or nil)
    end

end

local always_on = {
    condition = {
        first_signal = {
            name = "signal-anything",
            type = "virtual"
        },
        comparator = "≠",
        constant = 0,
        second_signal = nil
    },
    connect_to_logistic_network = false
}

---@param entity LuaEntity
---@param cache NixieCache
local function onTickAlpha(entity, cache)
    local charsig = getAlphaSignals(entity) or "off"

    ---@type Color?
    local color
    local control = cache.control
    if not (control and control.valid) then
        control = entity.get_or_create_control_behavior() --[[@as LuaLampControlBehavior]]
        cache.control = control
    end
    if control.use_colors then
        control.circuit_condition = always_on
        color = control.color
    end

    setStates(entity, cache, {charsig}, color)
end

local function onTick()
    for _ = 1, settings.global["nixie-tube-update-speed-numeric"].value do
        ---@type LuaEntity?
        local nixie
        if global.next_controller and not global.controllers[global.next_controller] then
            global.next_controller = nil
        end

        global.next_controller, nixie = next(global.controllers, global.next_controller)

        if nixie then
            if nixie.valid then
                onTickController(nixie, getCache(global.next_controller))
            else
                log("cleaning up nixie tube " .. global.next_controller .. " destroyed without events")
                global.controllers[global.next_controller] = nil
                global.cache[global.next_controller] = nil
                global.next_controller = nil
            end
        end
    end

    for _ = 1, settings.global["nixie-tube-update-speed-alpha"].value do
        ---@type LuaEntity?
        local nixie
        if global.next_alpha and not global.alphas[global.next_alpha] then
            global.next_alpha = nil
        end
        global.next_alpha, nixie = next(global.alphas, global.next_alpha)

        if nixie then
            if nixie.valid then
                onTickAlpha(nixie, getCache(global.next_alpha))
            else
                log("cleaning up nixie tube " .. global.next_alpha .. " destroyed without events")
                global.alphas[global.next_alpha] = nil
                global.cache[global.next_alpha] = nil
                global.next_alpha = nil
            end
        end
    end
end

---@param entity LuaEntity
local function onPlaceEntity(entity)
    local num = validEntityName[entity.name]
    if num then
        local surf = entity.surface
        local cache = getCache(entity.unit_number)
        local sprites = cache.sprites
        for n = 1, num do
            -- place the /real/ thing(s) at same spot
            ---@type Vector
            local position
            if num == 1 then -- large tube, one sprite
                position = {
                    x = 1 / 32,
                    y = 1 / 32
                }
            elseif num == 2 then
                position = {
                    x = -9 / 64 + ((n - 1) * 20 / 64),
                    y = 3 / 64
                } -- sprite offset
            elseif num == 3 then
                position = {
                    x = -35 / 64 + ((n - 1) * 36 / 64),
                    y = 2.5 / 64
                } -- sprite offset
            end
						local sprite
            if num < 3 then
                sprite = rendering.draw_sprite {
                    sprite = "nixie-tube-sprite-off",
                    target = entity,
                    target_offset = position,
                    surface = entity.surface,
                    tint = {
                        r = 1.0,
                        g = 1.0,
                        b = 1.0,
                        a = 1.0
                    },
                    x_scale = 1 / num,
                    y_scale = 1 / num,
                    render_layer = "object"
                }
            elseif num == 3 then
                sprite = rendering.draw_sprite {
                    sprite = "nixie-tube-sprite-off",
                    target = entity,
                    target_offset = position,
                    surface = entity.surface,
                    tint = {
                        r = 1.0,
                        g = 1.0,
                        b = 1.0,
                        a = 1.0
                    },
                    x_scale = 0.9,
                    y_scale = 1 / 2,
                    render_layer = "object"
                }
            end

            sprites[n] = sprite
        end

        cache.control = entity.get_or_create_control_behavior() --[[@as LuaLampControlBehavior]]

        if entity.name == "nixie-tube-alpha" then
            global.alphas[entity.unit_number] = entity
        else

            -- enslave guy to left, if there is one
            if (num == 3) then
                soused = 2
            else
                soused = 1
            end

            local neighbors = surf.find_entities_filtered {
                position = {
                    x = entity.position.x - soused,
                    y = entity.position.y
                },
                name = entity.name
            }
            for _, n in pairs(neighbors) do
                if n.valid then
                    if global.next_controller == n.unit_number then
                        -- if it's currently the *next* controller, claim that too...
                        global.next_controller = entity.unit_number
                    end

                    global.controllers[n.unit_number] = nil
                    global.nextdigit[entity.unit_number] = n
                end
            end

            -- slave self to right, if any
            neighbors = surf.find_entities_filtered {
                position = {
                    x = entity.position.x + soused,
                    y = entity.position.y
                },
                name = entity.name
            }
            local foundright = false
            for _, n in pairs(neighbors) do
                if n.valid then
                    foundright = true
                    global.nextdigit[n.unit_number] = entity
                end
            end
            if not foundright then
                global.controllers[entity.unit_number] = entity
            end
        end
    end
end

---@param entity LuaEntity
local function onRemoveEntity(entity)
    if entity.valid then
        if validEntityName[entity.name] then

            -- if I was a controller, deregister
            if global.next_controller == entity.unit_number then
                -- if i was the *next* controller, restart iteration...
                global.next_controller = nil
            end
            global.controllers[entity.unit_number] = nil

            -- if i was an alpha, deregister
            if global.next_alpha == entity.unit_number then
                -- if i was the *next* alpha, restart iteration...
                global.next_controller = nil
            end
            global.alphas[entity.unit_number] = nil
            global.cache[entity.unit_number] = nil

            local nextdigit = global.nextdigit[entity.unit_number]
            -- if I had a next-digit, register it as a controller
            if nextdigit and nextdigit.valid then
                global.controllers[nextdigit.unit_number] = nextdigit
                displayValString(nextdigit)
                global.nextdigit[entity.unit_number] = nil
            end
            -- if i was a next-digit, unlink
            for k, v in pairs(global.nextdigit) do
                if v == entity then
                    global.nextdigit[k] = nil
                    break
                end
            end

        end
    end
end

local function RegisterPicker()
    if remote.interfaces["picker"] and remote.interfaces["picker"]["dolly_moved_entity_id"] then
        script.on_event(remote.call("picker", "dolly_moved_entity_id"), function(event)
            onRemoveEntity(event.moved_entity)
            onPlaceEntity(event.moved_entity)
        end)
    end
end

script.on_init(function()
    global.alphas = {}
    global.controllers = {}
    global.cache = {}
    global.nextdigit = {}

    RegisterStrings()
    RegisterPicker()
end)

script.on_load(function()
    RegisterStrings()
    RegisterPicker()
end)

local function RebuildNixies()
    -- clear the tables
    global = {
        alphas = {},
        controllers = {},
        cache = {},
        nextdigit = {}
    }

    -- wipe out any lingering sprites i've just deleted the references to...
    rendering.clear("NixieTubesThreeDigits")

    -- and re-index the world
    for _, surf in pairs(game.surfaces) do
        -- re-index all nixies. non-nixie lamps will be ignored by onPlaceEntity
        for _, lamp in pairs(surf.find_entities_filtered {
            type = "lamp"
        }) do
            onPlaceEntity(lamp)
        end
    end
end

remote.add_interface("NixieTubesThreeDigits", {
    RebuildNixies = RebuildNixies
})

commands.add_command("RebuildNixies", "Reset all Nixie Tubes to clear display glitches.", RebuildNixies)

script.on_configuration_changed(function(data)
    if data.mod_changes and data.mod_changes["NixieTubesThreeDigits"] then
        RebuildNixies()
    end
end)

local filters = {}
local names = {}
for name in pairs(validEntityName) do
    filters[#filters + 1] = {
        filter = "name",
        name = name
    }
    filters[#filters + 1] = {
        filter = "ghost_name",
        name = name
    }
    names[#names + 1] = name
end

script.on_event(defines.events.on_built_entity, function(event)
    onPlaceEntity(event.created_entity)
end, filters)
script.on_event(defines.events.on_robot_built_entity, function(event)
    onPlaceEntity(event.created_entity)
end, filters)
script.on_event(defines.events.script_raised_built, function(event)
    onPlaceEntity(event.entity)
end)
script.on_event(defines.events.script_raised_revive, function(event)
    onPlaceEntity(event.entity)
end)
script.on_event(defines.events.on_entity_cloned, function(event)
    onPlaceEntity(event.destination)
end)

script.on_event(defines.events.on_pre_player_mined_item, function(event)
    onRemoveEntity(event.entity)
end, filters)
script.on_event(defines.events.on_robot_pre_mined, function(event)
    onRemoveEntity(event.entity)
end, filters)
script.on_event(defines.events.on_entity_died, function(event)
    onRemoveEntity(event.entity)
end, filters)
script.on_event(defines.events.script_raised_destroy, function(event)
    onRemoveEntity(event.entity)
end)
script.on_event(defines.events.on_pre_chunk_deleted, function(event)
    for _, chunk in pairs(event.positions) do
        local x = chunk.x
        local y = chunk.y
        local area = {{x * 32, y * 32}, {31 + x * 32, 31 + y * 32}}
        for _, ent in pairs(game.get_surface(event.surface_index).find_entities_filtered {
            name = names,
            area = area
        }) do
            onRemoveEntity(ent)
        end
    end
end)
script.on_event(defines.events.on_pre_surface_cleared, function(event)
    for _, ent in pairs(game.get_surface(event.surface_index).find_entities_filtered {
        name = names
    }) do
        onRemoveEntity(ent)
    end
end)
script.on_event(defines.events.on_pre_surface_deleted, function(event)
    for _, ent in pairs(game.get_surface(event.surface_index).find_entities_filtered {
        name = names
    }) do
        onRemoveEntity(ent)
    end
end)

script.on_event(defines.events.on_tick, onTick)
