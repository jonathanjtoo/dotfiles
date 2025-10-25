-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost", "InsertEnter" }, {
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = false
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local buf_map = function(mode, rhs, lhs)
			vim.keymap.set(mode, rhs, lhs, {buffer = event.buf})
		end

		-- These keymaps are the defaults in Neovim v0.11
		buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
		buf_map('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>')
		buf_map('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>')
		buf_map('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>')
		buf_map('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>')
		buf_map('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
		buf_map({'i', 's'}, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

		-- These are custom keymaps
		-- Go to definition
		buf_map({'n', 'v'}, 'gd', vim.lsp.buf.definition)
		-- Peek definition (open definition in a floating window)
		buf_map({'n', 'v'}, 'gD', vim.lsp.buf.declaration)

		-- Hover documentation
		buf_map('n', 'K', vim.lsp.buf.hover)

		-- Show diagnostics
		buf_map('n', '<leader>d', vim.diagnostic.open_float)
		-- Go to next diagnostic message
		buf_map('n', ']d', vim.diagnostic.goto_next)

		-- Go to previous diagnostic message
		buf_map('n', '[d', vim.diagnostic.goto_prev)

		-- Rename symbol
		buf_map('n', '<leader>rn', vim.lsp.buf.rename)

		-- Code actions
		buf_map('n', '<leader>ca', vim.lsp.buf.code_action)
	end,
})

vim.api.nvim_create_autocmd({"InsertEnter"}, {
    callback = function()
        -- vim.opt_local.formatoptions:remove({"c", "r", "o"})
	vim.opt_paste = true
    end
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
    callback = function()
        -- vim.opt_local.formatoptions:append({"c", "r", "o"})
	vim.opt_paste = false
    end
})
