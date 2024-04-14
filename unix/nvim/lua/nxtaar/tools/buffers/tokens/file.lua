return {
    group = {
        {
            content = function(entry)
                return entry.devicons
            end,
            hl = function(entry)
                return entry.devicons_highlight
            end
        },
        {
            width = function(meta)
                return meta.longest_buffer_filename_length
            end,
            content = function(entry)
                return entry.file_name
            end,
            -- hl_range = function(_, _, all_with)
            --     return all_with('Error')
            --     -- return { { { 1, 3 }, 'Error' }, { { 4, 5 }, 'Special' } }
            -- end
        }
    }
}
