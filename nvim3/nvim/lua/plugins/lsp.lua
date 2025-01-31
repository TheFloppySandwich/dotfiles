local minideps = require("mini.deps")

local add, now = minideps.add, minideps.now

now(function()
	add({
		source = "williamboman/mason-lspconfig.nvim",
		depends = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	})


	local handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup{}
		end,
		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup({
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.loop.fs_stat(path..'/.luarc.json') or
							vim.loop.fs_stat(path..'/.luarc.jsonc') then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							version = 'LuaJIT'
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
							}
						}
					})
				end,
				settings = {
					Lua = {}
				}
			})
		end,
	}
	require("mason").setup{}
	require("mason-lspconfig").setup{
		ensure_installed = { "lua_ls", "gopls", "ruff", },
		handlers = handlers,
	}
end)

