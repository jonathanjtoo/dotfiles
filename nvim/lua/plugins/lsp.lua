return {
 	{
 		"mason-org/mason.nvim",
		opts = {},
 	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
 	{
 		"hrsh7th/nvim-cmp",
 		dependencies = { "hrsh7th/cmp-nvim-lsp" },
 	},
}
