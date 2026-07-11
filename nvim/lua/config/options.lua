-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set inital formatting options
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.tabstop = 4             -- Visual width of a tab character
vim.opt.shiftwidth = 4          -- Indentation width for >> and <<
vim.opt.softtabstop = 4         -- Spaces inserted when pressing <Tab>
vim.opt.autoindent = true       -- Copy indent from current line on new line

-- Set minimal number of screen lines to keep above or below the cursor
vim.opt.scrolloff = 5

-- UI and navigation
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.lazyredraw = true

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Editing behavior
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.history = 50

-- Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false

-- Enable case-insensitive filename and command completion
if vim.fn.exists("&wildignorecase") == 1 then
  vim.opt.wildignorecase = true
end

-- Use wilder.nvim instead for wildmenu now
-- -- Enable wildmenu and configure wildmode behavior
-- if vim.fn.has("wildmenu") == 1 then
--   vim.opt.wildmenu = true
--   vim.opt.wildmode = { "list", "longest", "full" }
-- end

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

-- Toggle list mode with custom listchars
vim.api.nvim_create_user_command("ToggleList", function()
  if vim.o.list then
    -- Turn off list mode
    vim.o.list = false
    print("List mode disabled")
  else
    -- Turn on list mode with custom symbols
    vim.o.list = true
    vim.o.listchars = "tab:>-,trail:~,extends:>,precedes:<,nbsp:%,eol:$"
    print("List mode enabled")
  end
end, {})

-- Toggle .editorconfig support
vim.api.nvim_create_user_command("ToggleEditorConfig", function()
  if vim.g.editorconfig == false then
    vim.g.editorconfig = true
    print("EditorConfig enabled")
  else
    vim.g.editorconfig = false
    print("EditorConfig disabled")
  end
end, {})
