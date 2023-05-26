return {
    'mbbill/undotree',
    'nvim-tree/nvim-web-devicons',
    'stevearc/oil.nvim',
    'sainnhe/everforest',
    'nvim-lua/plenary.nvim',
    'tpope/vim-fugitive',
    'rbong/vim-flog',
    'tpope/vim-unimpaired',
    'folke/neodev.nvim',
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            {'b0o/schemastore.nvim'},

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    }
}
