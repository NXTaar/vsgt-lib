return {
    -- Clear highlighted selection
    { key = '<C-n>', cmd = 'noh' },

    -- Split-screen navigation
    { key = '<C-h>', cmd = '<C-w>h' },
    { key = '<C-j>', cmd = '<C-w>j' },
    { key = '<C-k>', cmd = '<C-w>k' },
    { key = '<C-l>', cmd = '<C-w>l' },

    -- Version control
    { l_key = 'gg',  action = 'git.open-figutive' },
    { l_key = 'gtr', action = 'git.open-flog-tree' },

    -- Source file
    { l_key = 'sc',  cmd = ":source % | echo 'File '.expand('%').' sourced successfully'" },

    -- File navigation
    { l_key = 'f',   action = 'telescope.find-in-files' },
    { l_key = '-',   action = 'oil.open' },

    -- LSP
    {
        key = 'K',
        action = 'lsp.show-hint',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = 'gd',
        action = 'lsp.go-to-definition',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = 'gD',
        action = 'lsp.go-to-declaration',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = 'gi',
        action = 'lsp.go-to-implementation',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = 'go',
        action = 'lsp.go-to-type-definition',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = 'gr',
        action = 'lsp.go-to-references',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = 'gs',
        action = 'lsp.signature-help',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        l_key = 'rn',
        action = 'lsp.rename',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = '<F3>',
        action = 'lsp.format-async',
        mode = { 'n', 'x' },
        silent = false,
        remap = false,
        buffer = true,
    },
    {
        l_key = 'x',
        action = 'lsp.code-action',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        l_key = 'i',
        action = 'lsp.show-info',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = '[d',
        action = 'lsp.diagnostic-go-to-prev',
        silent = false,
        remap = false,
        buffer = true
    },
    {
        key = ']d',
        action = 'lsp.diagnostic-go-to-next',
        silent = false,
        remap = false,
        buffer = true
    },
    { l_key = 'li', action = 'lsp.show-lsp-info' },

    -- Typescript
    { l_key = 'ti', action = 'typescript.add-missing-imports',   buffer = true },
    { l_key = 'tu', action = 'typescript.remove-unused-imports', buffer = true },

    -- Code completion
    { key = '<CR>', action = 'completion.select' },
}
