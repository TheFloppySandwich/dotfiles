local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd("echo 'Installing `mini.nvim`' | redraw")
  local clone_cmd = {
    "git", "clone", "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim", mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
end

require("mini.deps").setup({ path = { package = path_package }})

local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local mini = function(p, c) require("mini."..p).setup(c) end

now(function()
	add({
		source = "rose-pine/neovim"
	})
	vim.cmd("colorscheme rose-pine")
	mini("icons", {})
	mini("statusline", {})
	mini("tabline", {})
	mini("cursorword", {})
	-- mini("hipatterns",{}) -- Fix highlightthings
	mini("notify", {})
	mini("indentscope", { draw = { animation = function() return 0 end }})
end)

later(function()
	mini("files", {})
	mini("git", {})
	mini("diff", {})
	mini("surround", {})
	require("plugins.clue")
end)
