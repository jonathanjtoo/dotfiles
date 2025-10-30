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
    end
  }
}
