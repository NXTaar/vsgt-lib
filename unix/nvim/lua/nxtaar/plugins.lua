return {
    'mbbill/undotree',
    -- File system
    'stevearc/oil.nvim',

    -- Colorscheme
    'sainnhe/everforest',

    -- Git
    'tpope/vim-fugitive',
    'rbong/vim-flog',
    'idanarye/vim-merginal',

    'tpope/vim-unimpaired',

    -- Comments
    'JoosepAlviste/nvim-ts-context-commentstring',
    'terrortylor/nvim-comment',

    -- Bottomline
    'nvim-lualine/lualine.nvim',

    -- Navigation
    'phaazon/hop.nvim',
    'ThePrimeagen/harpoon',

    -- Internal
    'folke/neodev.nvim', -- neovim related lsp
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    'b0o/schemastore.nvim',   -- schemas for common config files
    'stevearc/dressing.nvim', -- proper UI elements

    'toppair/reach.nvim',
    'tpope/vim-surround',
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {}
    },
    'Wansmer/treesj',
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
            { 'folke/trouble.nvim' }
        }
    },
}
