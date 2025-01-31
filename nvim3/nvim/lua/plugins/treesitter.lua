local minideps = require("mini.deps")
local add, now = minideps.add, minideps.now

now(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "master",
		monitor = "main",
		hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
	})
	require("nvim-treesitter.configs").setup{
		ensure_installed = { "lua", "vimdoc", "python", "go", "html", "hyprlang",  "markdown", "markdown_inline", },
		auto_install = true,
		highlight = {
			enable = true,
			disable = function(lang, buf)
				local max_filesize = 1024 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
	}

	-- vim.wo.foldmethod = 'expr'
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
end)
