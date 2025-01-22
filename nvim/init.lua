print "Well, Hello there!"
require("config.lazy")
require("compare_hi")

vim.keymap.set('n','<space>','<Nop>')
vim.keymap.set('n','<C-space>','<Nop>')

vim.keymap.set('i','<Up>',function() print("No! Try again!") end)
vim.keymap.set('i','<Down>',function() print("No! Try again!") end)
vim.keymap.set('i','<Left>',function() print("No! Try again!") end)
vim.keymap.set('i','<Right>',function() print("No! Try again!") end)

vim.keymap.set('n','<Up>',function() print("No! Try again!") end)
vim.keymap.set('n','<Down>',function() print("No! Try again!") end)
vim.keymap.set('n','<Left>',function() print("No! Try again!") end)
vim.keymap.set('n','<Right>',function() print("No! Try again!") end)

vim.keymap.set('i','<C-Space>', '<C-x><C-o>')
vim.keymap.set('n','<space><space>x','<cmd>source %<CR>')

vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yank',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})
