return {
  {
    -- branch 0.1.x seems to be outdated now
    -- 'nvim-telescope/telescope.nvim', branch = '0.1.x',
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      -- Helper: Get LSP root
      local function get_lsp_root()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
          local root = client.config.root_dir
          if root then return root end
        end
        return nil
      end

      -- Helper: Get Git root
      local function get_git_root()
        local git_cmd = { "git", "rev-parse", "--show-toplevel" }
        local result = vim.fn.systemlist(git_cmd)
        if vim.v.shell_error == 0 and result[1] ~= "" then
          return result[1]
        end
        return nil
      end

      -- Unified root resolver
      local function resolve_root()
        return get_lsp_root() or get_git_root() or vim.fn.getcwd()
      end
      -- Telescope setup
      telescope.setup({
        defaults = {
          -- Optional: set cwd globally for all pickers
          -- cwd = resolve_root()
        },
      })

      -- Load fzf native extension optionally
      -- telescope.load_extension('fzf')

      -- Keymaps for various LSP/Telescope pickers
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ cwd = resolve_root() })
      end, { desc = "Find files in project root" })

      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep({ cwd = resolve_root() })
      end, { desc = "Live grep in project root" })

      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers({ cwd = resolve_root() })
      end, { desc = "Buffers in project root" })
      vim.keymap.set("n", "<leader>fs", function()
        builtin.grep_string({ cwd = resolve_root() })
      end, { desc = "Search word under cursor" })

      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = "LSP references" })
      vim.keymap.set('n', '<leader>fd', builtin.lsp_document_symbols, { desc = "Document symbols" })
      vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
      vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "Pick buffer" })
    end
  },
  {
    'jakemason/ouroboros',
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- these are the defaults, customize as desired
    config = function()
      require('ouroboros').setup({
        extension_preferences_table = {
          -- Higher numbers are a heavier weight and thus preferred.
          -- In the following, .c would prefer to open .h before .hpp
          c = {h = 2, hpp = 1},
          h = {c = 2, cpp = 1},
          cpp = {hpp = 2, h = 1},
          hpp = {cpp = 1, c = 2},

          -- Ouroboros supports any combination of filetypes you like, simply
          -- add them as desired:
          -- myext = { myextsrc = 2, myextoldsrc = 1},
          -- tpp = {hpp = 2, h = 1},
          -- inl = {cpp = 3, hpp = 2, h = 1},
          -- cu = {cuh = 3, hpp = 2, h = 1},
          -- cuh = {cu = 1}
        },
        -- if this is true and the matching file is already open in a pane, we'll
        -- switch to that pane instead of opening it in the current buffer
        switch_to_open_pane_if_possible = true,

        -- Keymap to toggle between header/source: <leader>oh
        vim.keymap.set('n', '<leader>oo', function()
          vim.cmd.Ouroboros()
        end, { desc = "Toggle between header and source file" })
      })
    end
  }
}
