local M = {}

--- Ask user to confirm an action
---@param prompt string: The prompt for confirmation
---@param default_value string: The default value of user input
---@param yes_values table: List of positive user confirmations ({"y", "yes"} by default)
---@return boolean: Whether user confirmed the prompt
function M.ask_to_confirm(prompt, default_value, yes_values)
    yes_values = yes_values or { 'y', 'yes' }
    default_value = default_value or ''
    local confirmation = vim.fn.input(prompt, default_value)
    confirmation = string.lower(confirmation)
    if string.len(confirmation) == 0 then
        return false
    end
    for _, v in pairs(yes_values) do
        if v == confirmation then
            return true
        end
    end
    return false
end

return M
