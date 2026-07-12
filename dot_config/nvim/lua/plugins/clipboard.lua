return {
  "gbprod/yanky.nvim",
  lazy = false,  -- load on startup or true with proper lazy loading triggers
  dependencies = { "kkharji/sqlite.lua" }, -- if needed for yank history persistence
  opts = {
    highlight = { timer = 100 },  -- example config, disable or adjust as needed
    system_clipboard = {
      sync_with_ring = true,  -- sync yank ring with system clipboard
      clipboard_register = "+",
    },
  },
  keys = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Yank put after" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Yank put before" },
    { "<c-n>", "<Plug>(YankyCycleForward)", desc = "Cycle yank forward" },
    { "<c-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle yank backward" },
    { "<leader>p", "a<space><esc><Plug>(YankyPutAfter)", desc = "Insert space then yank put after" },
  },
  config = function(_, opts)
    require("yanky").setup(opts)
  end,
}

