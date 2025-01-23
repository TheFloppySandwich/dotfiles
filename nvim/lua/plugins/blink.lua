
return {
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',

		version = 'v0.*',

		opts = {
			keymap = {
				preset = 'super-tab',
				cmdline = { preset = 'none' } --{ preset = 'enter' },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			signature = { enabled = true },

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
