-- override the cmd in nvim-lspconfig to do --background-index
local function find_root()
  local path = vim.fs.find({ "compile_commands.json", ".git" }, { upward = true, type = "file" })[1]
  return path and vim.fs.dirname(path) or vim.fn.getcwd()
end

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    "--compile-commands-dir=" .. find_root(),
    "--pch-storage=memory",
  },
  root_dir = find_root(),
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})
