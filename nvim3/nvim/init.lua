print("Well, Hello there!")

vim.g.mapleader = "<space>"
vim.g.maplocalleader = "\\"

local desc = function(d) return { desc = d } end
local o = vim.opt
local kset = vim.keymap.set
kset("n", "<cr>", "<nop>")
o.termguicolors = true

require("plugins.mini")
require("plugins.treesitter")
require("plugins.lsp")

o.nu = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true

o.wrap = false

o.swapfile = false
o.backup = false

o.scrolloff = 8
o.signcolumn = "yes"
o.isfname:append("@-@")

-- Keys

kset("v", "J", ":m '>+1<CR>gv=gv", desc("Mv line down"))
kset("v", "K", ":m '<-2<CR>gv=gv", desc("Mv line up"))

kset("n", "<space><space>", function() vim.cmd("so") end, desc("Source ."))
