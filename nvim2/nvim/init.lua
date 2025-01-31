print "Well, Hello there!"

require("plugins.mini")

vim.g.mapleader = "<space>"
vim.g.maplocalleader = "\\"

-- unbind space
vim.keymap.set('n', '<space>', '<Nop>')
vim.keymap.set('n', '<C-space>', '<Nop>')


-- Other plugins
MiniDeps.now(function()
	MiniDeps.add({
		source = 'neovim/nvim-lspconfig',
		depends = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'simrat39/rust-tools.nvim' }
	})
	require('mason').setup {}
	require('mason-lspconfig').setup {
		ensure_installed = { 'lua_ls', 'ruff', 'pyright', 'rust_analyzer' },
		automatic_installation = false,
		handlers = {
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup {
				}
			end,
			["rust_analyzer"] = function()
				require("rust-tools").setup {}
			end,
			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT"
							},
							diagnostics = {
								globals = { "vim" }
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								}
							},
						},
					}
				}
			end,
		}
	}
end)
MiniDeps.now(function()
	MiniDeps.add({
		source = 'nvim-treesitter/nvim-treesitter',
		checkout = 'master',
		monitor = 'main',
		hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
	})
	require('nvim-treesitter.configs').setup({
		ensure_installed = { 'c', 'lua', 'vimdoc', 'python', 'rust' },
		auto_install = true,
		highlight = { enable = true },
	})
end)

MiniDeps.later(function()
	MiniDeps.add({
		source = 'nvim-telescope/telescope.nvim',

		depends = { 'nvim-lua/plenary.nvim' },
	})

	require('telescope').setup {}
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', '<space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', '<space>gg', builtin.git_files, { desc = 'Telescope find git files' })
	vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	vim.keymap.set('n', '<space>fc', builtin.command_history, { desc = 'Telescope command history' })
	vim.keymap.set('n', '<space>en', function()
		builtin.find_files {
			cwd = vim.fn.stdpath("config")
		}
	end)
	vim.keymap.set('n', '<space>ep', function()
		builtin.find_files {
			---@diagnostic disable-next-line: param-type-mismatch
			cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'site/pack/deps')
		}
	end)
end)

-- end Other plugins


-- Space commands
--vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>', { desc = 'Source curr file' })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = 'lua line' })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = 'lua sel' })

-- Unbind arrow keys
vim.keymap.set({ 'i', 'n' }, '<Up>', function() print("No! Try again!") end, { desc = 'Unbind arrow key' })
vim.keymap.set({ 'i', 'n' }, '<Down>', function() print("No! Try again!") end, { desc = 'Unbind arrow key' })
vim.keymap.set({ 'i', 'n' }, '<Left>', function() print("No! Try again!") end, { desc = 'Unbind arrow key' })
vim.keymap.set({ 'i', 'n' }, '<Right>', function() print("No! Try again!") end, { desc = 'Unbind arrow key' })

vim.keymap.set("n", "<space>fe", function() MiniFiles.open() end, { desc = 'Explore' })

-- megadelete (not cut)
vim.keymap.set({ 'n', 'v' }, '<space>d', '"_d', { desc = 'Void delete' })

vim.keymap.set('n', 'cw', 'ciw', { desc = 'cw -> ciw' })
vim.keymap.set('n', '0', '_', { desc = '0 -> _' })


vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')

-- Options
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "120"
vim.opt.swapfile = false

vim.o.completeopt = 'menu,fuzzy,noinsert,preview'

-- Highlight when yank
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yank',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

-- vim.api.nvim_create_autocmd('LspNotify', {
-- 	group = vim.api.nvim_create_augroup('Notifier', {}),
-- 	callback = function(args)
-- 		if args.data.method == 'textDocument/...' then
-- 			vim.notify_once(args.data.client_id, vim.log.levels.WARN)
-- 		end
-- 	end,
-- })
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		vim.notify_once('LSP attached', vim.log.levels.WARN)

		vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

		local opts = { buffer = args.buf }
		vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
		vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
		vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set('n', '<space>D', function() vim.lsp.buf.type_definition() end, opts)
		vim.keymap.set('n', '<space>rn', function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
		vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format() end, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', function() vim.lsp.buf.code_action() end, opts)

		vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set('n', '<space>dq', function() vim.diagnostic.setloclist() end, opts)
		vim.keymap.set('n', '<space>df', function() vim.diagnostic.open_float({ bufnr = args.buf }) end, opts)
	end,
})

