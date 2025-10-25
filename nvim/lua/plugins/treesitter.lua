return {
    {"nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc'},
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            }
        }
    }
}
