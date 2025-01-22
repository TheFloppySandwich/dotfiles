-- Lua function to compare highlight groups
local function compare_highlight_groups(colorscheme1, colorscheme2)
  local function get_highlight_groups(cs)
    vim.cmd("silent colorscheme " .. cs)
    local output = vim.fn.execute("hi")
    local groups = {}
    for line in output:gmatch("[^\r\n]+") do
      local parts = vim.split(line, "%s+")
      if #parts > 1 and parts[1] ~= "link" then -- Ignore links
        local group_name = parts[1]
        local attrs = {}
        for i = 2, #parts do
          local kv = vim.split(parts[i], "=")
          if #kv == 2 then
            attrs[kv[1]] = kv[2]
          end
        end
        groups[group_name] = attrs
      end
    end
    return groups
  end

  local current_colorscheme = vim.g.colors_name
  local groups1 = get_highlight_groups(colorscheme1)
  local groups2 = get_highlight_groups(colorscheme2)
  vim.cmd("colorscheme " .. current_colorscheme)

  -- Compare the groups and print the differences
  for group, attrs1 in pairs(groups1) do
    local attrs2 = groups2[group]
    if attrs2 then
      for attr, val1 in pairs(attrs1) do
        local val2 = attrs2[attr]
        if val1 ~= val2 then
          print(string.format("Group: %s, Attribute: %s, %s: %s, %s: %s", group, attr, colorscheme1, val1, colorscheme2, val2))
        end
      end
    else
      print(string.format("Group %s only in %s", group, colorscheme1))
    end
  end
    for group, attrs2 in pairs(groups2) do
    local attrs1 = groups1[group]
    if not attrs1 then
      print(string.format("Group %s only in %s", group, colorscheme2))
    end
  end
end

-- Example usage:
vim.api.nvim_create_user_command("CompareHi", function(args) print("comp: " .. args.fargs[1] .. " " .. args.fargs[2]) compare_highlight_groups(args.fargs[1], args.fargs[2]) end, { nargs="*" })
