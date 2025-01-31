return {
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',

		version = 'v0.*',

		opts = {
			enabled = function()
				local filetype = vim.bo[0].filetype
				if filetype == "TelescopePrompt" then
					return false
				end
				return true
			end,
			keymap = {
				preset = 'super-tab',
				cmdline = { preset = 'none',
					-- ['<Up>'] = { 'select_next', 'fallback' },
					-- ['<Down>'] = { 'select_next', 'fallback' },
				}, --{ preset = 'enter' },

				['<CR>'] = { 'select_and_accept', 'fallback' },
				['<C-k>'] = { 'select_prev' },
				['<C-j>'] = { 'select_next' },
			},

			completion = {
				list = {
					selection = {
						auto_insert = function (ctx)
							return ctx.mode == 'cmdline'
						end,
					},
				},
				ghost_text = {
					enabled = true
				},
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			signature = {
				enabled = true,
				window = {
					--show_documentation = false,
				},
			},

			sources = {

				cmdline = function()
					local type = vim.fn.getcmdtype()
					if type == '/' or type == '?' then return { 'buffer' } end
					return {}
				end,

				min_keyword_length = 1,
			}
		},
	},
}
