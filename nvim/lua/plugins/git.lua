return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup {
        numhl = true,
        linehl = true,
        word_diff = true,
        current_line_blame = true,
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end, {desc = "Go to next hunk"})

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end, {desc = "Go to prev hunk"})

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, {desc = "stage hunk (toggle)"})
          map('n', '<leader>hr', gitsigns.reset_hunk, {desc = "reset hunk"})

          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, {desc = "stage hunk (toggle)"})

          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, {desc = "reset hunk"})

          map('n', '<leader>hS', gitsigns.stage_buffer, {desc = "stage buffer (toggle)"})
          map('n', '<leader>hR', gitsigns.reset_buffer, {desc = "reset buffer"})
          map('n', '<leader>hp', gitsigns.preview_hunk, {desc = "preview hunk"})
          map('n', '<leader>hi', gitsigns.preview_hunk_inline, {desc = "preview hunk inline"})

          map('n', '<leader>hb', function()
            gitsigns.blame_line({ full = true })
          end, {desc = "blame_line full"})

          map('n', '<leader>hB', gitsigns.blame, {desc = "blame (toggle)"})

          map('n', '<leader>hd', gitsigns.diffthis, {desc = "diffthis"})

          map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
          end, {desc = "diffthis('~')"})

          map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, {desc = "quickfix list (All)"})
          map('n', '<leader>hq', gitsigns.setqflist, {desc = "quickfix list"})

          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, {desc = "toggle_current_line_blame"})
          map('n', '<leader>tw', gitsigns.toggle_word_diff, {desc = "toggle_word_diff"})

          -- Text object
          map({'o', 'x'}, 'ih', gitsigns.select_hunk, {desc = "select_hunk"})
        end
      }
    end,
  },
}

