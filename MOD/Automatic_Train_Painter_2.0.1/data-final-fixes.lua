local extendedgrid = {}

local function addcat(name)
    local grid = data.raw["equipment-grid"][name]
    if grid and grid.equipment_categories and not extendedgrid[grid.name] then
        local found = false
        for _, category in pairs(grid.equipment_categories) do
            if category == "atp-equipment-category" then
                found = true
                break
            end
        end
        if not found then
            table.insert(grid.equipment_categories, "atp-equipment-category")
            extendedgrid[grid.name] = true
        end
    end
end

for _, loco in pairs(data.raw.locomotive) do
    if settings.startup['loc-eqpm-grid'].value then
        if not loco.equipment_grid then
            loco.equipment_grid = "atp-equipment-grid"
        else
            addcat(loco.equipment_grid)
        end
    else
        if loco.equipment_grid then
            addcat(loco.equipment_grid)
        end
    end
end

data.raw["locomotive"]["locomotive"].default_copy_color_from_train_stop = false
data.raw["cargo-wagon"]["cargo-wagon"].default_copy_color_from_train_stop = false
data.raw["fluid-wagon"]["fluid-wagon"].default_copy_color_from_train_stop = false