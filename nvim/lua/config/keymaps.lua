-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>rr", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^plugins") or name:match("^core") or name:match("^config") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  vim.notify("Reloaded Neovim config", vim.log.levels.INFO)
end, { desc = "Reload Neovim config" })

-- Movement remaps (gj/gk for wrapped lines)
vim.keymap.set("n", "j", "(v:count == 0 ? 'gj' : 'j')", { expr = true, silent = true })
vim.keymap.set("n", "k", "(v:count == 0 ? 'gk' : 'k')", { expr = true, silent = true })

