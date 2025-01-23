print "Well, Hello there!"

require("config.lazy")

-- unbind space
vim.keymap.set('n', '<space>', '<Nop>')
vim.keymap.set('n', '<C-space>', '<Nop>')

-- Space commands
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>F', 'ggVGgq')

-- Unbind arrow keys
vim.keymap.set({ 'i', 'n' }, '<Up>', function() print("No! Try again!") end)
vim.keymap.set({ 'i', 'n' }, '<Down>', function() print("No! Try again!") end)
vim.keymap.set({ 'i', 'n' }, '<Left>', function() print("No! Try again!") end)
vim.keymap.set({ 'i', 'n' }, '<Right>', function() print("No! Try again!") end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<space>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<space>en', function() builtin.find_files { cwd = vim.fn.stdpath("config") } end)

-- vim.keymap.set('i', '<c-j>',
-- vim.keymap.set('i', '<c-k>',

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

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Highlight when yank
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yank',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})
