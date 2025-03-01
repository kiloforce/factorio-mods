exemptions={
    ["AutomaticTrainPainter"]={"manual-color-module"},
    ["Shuttle_Train_Continued"]={"shuttle-lite"},
    ["FARL"]={"farl-roboport"},
}

removals={
    ["CompressedFluids"]={"high%-pressure%-"},
    ["DirtyMining"]={"dirty%-ore%-"},
    ["Liquify"]={"liquify2%-solution%-"},
    ["nullius"]={"box%-"},
    ["omnimatter_crystal"]={"%-omnide%-solution"},
    ["omnimatter_crystal"]={"%-omnide%-salt"},
    ["omnimatter_fluid"]={"solid%-"},
}

function exemption_check(train)
    for _,v in pairs(exemptions) do
        if train.front_stock.grid and train.front_stock.grid.equipment then
            for _, eq in pairs(train.front_stock.grid.equipment) do
                if eq.name == v[1] then
                    return true
                end
            end
        end
    end
    return false
end