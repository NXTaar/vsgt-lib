return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            options = {
                theme = 'nordic',
            },
            extensions = { 'oil', 'lazy', 'mason' }
        }
    }
}
