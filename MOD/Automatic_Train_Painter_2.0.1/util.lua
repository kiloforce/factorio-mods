function normalize(content, norm_val)
    if content == nil then
        return nil
    end

    local normed_content = {}
    for index, value in pairs(content) do
        normed_content[index] = value/norm_val
    end
    return normed_content
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function name_count_extractor(tbl)
    local output_table = {}
    for _, v in pairs(tbl) do
        local key, value
        -- Extract name and count from the table
        for l, w in pairs(v) do
            if l == "name" then
                key = w
            end
            if l == "count" then
                value = w
            end
        end
        -- Add or increment the name and count to the transformed table
        if output_table[key] == nil then
            output_table[key] = value
        else
            output_table[key] = output_table[key] + value
        end
    end
    return output_table
end

function tableMerge(t1, t2)
    if t1 == nil or t2 == nil then
        return t1 or t2
    end

    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

function listMerge(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

function printf(content)
    if type(content) == 'table' then
        --        game.print("nil")
        return
    end
    for key, value in pairs(content) do
        game.print(key,value)
    end
end

function pprint(content)
    if game ~= nil then
        game.print(content)
    end
end

function split(str, pat)
    local t = {}
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(t,cap)
        end
        last_end = e+1
        s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
        cap = str:sub(last_end)
        table.insert(t, cap)
    end
    return t
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function sort_string(str)
    local tab = {}
    str:gsub(".",function(c) table.insert(tab,c) end)
    table.sort(tab)
    str = table.concat(tab)
    return str
end

function convert_string_to_table(s)
    local t = (loadstring)("return "..s)()
    return t
end