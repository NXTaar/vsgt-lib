return {
    'mbbill/undotree',
    'stevearc/oil.nvim',

    -- Colorscheme
    'sainnhe/everforest',

    -- Git
    'tpope/vim-fugitive',
    'rbong/vim-flog',

    'tpope/vim-unimpaired',

    'b0o/schemastore.nvim',
    -- Comments
    'JoosepAlviste/nvim-ts-context-commentstring',
    'terrortylor/nvim-comment',

    -- Bottomline
    'nvim-lualine/lualine.nvim',

    -- Internal
    'folke/neodev.nvim', -- neovim related lsp
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- proper UI elements
    
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
            { 'neovim/nvim-lspconfig' },

            -- Language server manager
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Improved Typescript support
            { 'jose-elias-alvarez/typescript.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
}
