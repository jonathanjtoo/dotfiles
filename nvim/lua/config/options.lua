-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set inital formatting options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Set minimal number of screen lines to keep above or below the cursor
vim.opt.scrolloff = 10

if not vim.g.vscode then
	vim.opt.clipboard:append "unnamedplus"
	vim.g.clipboard = {
		name = 'OSC 52',
		copy = {
			['+'] = require('vim.ui.clipboard.osc52').copy '+',
			['*'] = require('vim.ui.clipboard.osc52').copy '*',
		},
		paste = {
			['+'] = require('vim.ui.clipboard.osc52').paste '+',
			['*'] = require('vim.ui.clipboard.osc52').paste '*',
		},
	}
end
