
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			}
		},
		config = function()

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("lspconfig").lua_ls.setup { capabilities = capabilities }
			require("lspconfig").pyright.setup {
				capabilities = capabilities,
				settings = {
					pyright = {
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							ignore = { '*' },
						},
					},
				},
			}
			require("lspconfig").ruff.setup {
				capabilities = capabilities,
				init_options = {
					settings = {
						logLevel = 'debug',
					}
				}
			}
		end,
	}
}
