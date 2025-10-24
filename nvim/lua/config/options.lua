-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.clipboard = {
  name = 'OSC52',
  copy = {
    ['+'] = require('vim.clipboard.osc52').copy,
    ['*'] = require('vim.clipboard.osc52').copy,
  },
  paste = {
    ['+'] = require('vim.clipboard.osc52').paste,
    ['*'] = require('vim.clipboard.osc52').paste,
  },
}

vim.opt.clipboard = "unnamedplus"
