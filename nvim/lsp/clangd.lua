-- override the cmd in nvim-lspconfig to do --background-index
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index' },
})
