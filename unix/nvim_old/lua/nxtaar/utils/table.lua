local exports = {}

function exports.tbl_find(tbl, comparator)
    local result = nil

    for key, value in pairs(tbl) do
        local comparison = comparator(value, key)

        if comparison then
            result = value
            break
        end
    end

    return result
end

return exports
