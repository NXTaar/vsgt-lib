local comment = require("Comment")
local utils = require("Comment.utils")

local get_cursor_location = require("ts_context_commentstring.utils").get_cursor_location
local get_visual_start_location = require("ts_context_commentstring.utils").get_visual_start_location
local calculate_commentstring = require("ts_context_commentstring.internal").calculate_commentstring

local exports = {}

function exports.init()
    comment.setup {
        pre_hook = function(ctx)

            local location = nil
            if ctx.ctype == utils.ctype.block then
                location = get_cursor_location()
            elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
                location = get_visual_start_location()
            end

            return calculate_commentstring {
                key = ctx.ctype == utils.ctype.line and "__default" or "__multiline",
                location = location,
            }
        end
    }
end

function exports.plugin(use)
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"
end

return exports
