-- Mini.deps init
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		-- Uncomment next line to use 'stable' branch
		-- '--branch', 'stable',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })
-- end Mini.deps init --

-- Mini.nvim setups
local now, add, later = MiniDeps.now, MiniDeps.add, MiniDeps.later

-- Ui things now --

now(function()
	require('mini.notify').setup {
		content = {
			sort = function(notification_arr)
				table.sort(notification_arr, function(a, b) return a.ts_update < b.ts_update end)
				return notification_arr
			end,
		},
	}
	vim.notify = require('mini.notify').make_notify()
end)

now(function()
	vim.o.termguicolors = true
	add({
		source = 'rose-pine/neovim',
	})
	vim.cmd('colorscheme rose-pine-moon')
end)

now(function()
	require('mini.icons').setup {}
	require('mini.cursorword').setup {}
	require('mini.indentscope').setup {
		draw = { animation = function() return 0 end }
	}
	require('mini.statusline').setup {}
	require('mini.tabline').setup {}
end)

-- Mini text editing
later(function()
	require('mini.ai').setup {}
	require('mini.operators').setup {}
	require('mini.pairs').setup {}

end)

-- Mini general
later(function()
	require('mini.bracketed').setup {}
	require('mini.git').setup {}
	require('mini.diff').setup {}
	require('mini.files').setup {}
end)

-- Things with more setup here --

later(function()
	add({
		source = 'rafamadriz/friendly-snippets'
	})
	local snip_loader = require('mini.snippets').gen_loader
	require('mini.snippets').setup {
		snippets = {
			snip_loader.from_lang(),
		}
	}
end)

later(function()
	require('mini.completion').setup {
		-- fallback_action = '<C-x><C-n',
		mappings = {
			force_twostep = '<C-space>',
		},
		lsp_completion = {
			auto_setup = false,
			source_func = 'omnifunc',
			process_items = require('mini.completion').default_process_items,
		},
		delay = { completion = 100, info = 10 ^ 7 },
		set_vim_settings = false,
	}
end)

later(function()
	require('mini.surround').setup {}
	local miniclue = require('mini.clue')
	miniclue.setup {
		window = {
			config = {
				width = 50,
			}
		},
		triggers = {
			-- Leader triggers
			{ mode = 'n', keys = '<space>' },
			{ mode = 'x', keys = '<space>' },
			-- Built-in completion
			{ mode = 'i', keys = '<C-x>' },
			-- `g` key
			{ mode = 'n', keys = 'g' },
			{ mode = 'x', keys = 'g' },
			-- Marks
			{ mode = 'n', keys = "'" },
			{ mode = 'n', keys = '`' },
			{ mode = 'x', keys = "'" },
			{ mode = 'x', keys = '`' },
			-- Registers
			{ mode = 'n', keys = '"' },
			{ mode = 'x', keys = '"' },
			{ mode = 'i', keys = '<C-r>' },
			{ mode = 'c', keys = '<C-r>' },
			-- Window commands
			{ mode = 'n', keys = '<C-w>' },
			-- `z` key
			{ mode = 'n', keys = 'z' },
			{ mode = 'x', keys = 'z' },
		},
		clues = {
			-- Enhance this by adding descriptions for <Leader> mapping groups
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
		},
	}
end)

