local options = {
 default_size = 10,
 change_up=1,
 change_down=-1,
 maximum = 30,
 minimum = 2,
}

local vim_opt=vim.opt
local function get_size_now()
 return tonumber(string.match(vim_opt.guifont._value,":h(%d+)"))
end
local function set_font_size(size)
 size=tostring(size)
 vim.rpcnotify(0, 'Gui', 'Font', string.gsub(vim_opt.guifont._value,":h%d+",":h"..size), "!")
end

local function size_limit(size)
 if size>options.maximum then
  print("Size reached the boundary of maximum")
  return options.maximum
 elseif size<options.minimum then
  print("Size reached the boundary of minimum")
  return options.minimum
 end
 return size
end
local function font_size_change(size)
 size=size_limit(size+get_size_now())
 set_font_size(size)
end
local function font_size_set(size)
 size=size_limit(size)
 set_font_size(size)
end

local Actions_Change={
 Up=function()
  font_size_change(options.change_up)
 end,
 Down=function()
  font_size_change(options.change_down)
 end,
}
local function Change(arg)
 local action=Actions_Change[arg]
 if action then
  action()
  return
 end
 local size=tonumber(arg)
 font_size_change(size)
end

local Actions_Set={
 Default=function()
  font_size_set(options.default_size)
 end
}
local function Set(arg)
 local action=Actions_Set[arg]
 if action then
  action()
  return
 end
 local size=tonumber(arg)
 font_size_set(size)
end

local Actions_FontSize={
 Change=Change,
 Set=Set,
}
local function FontResizer(cmd)
 local fargs=cmd.fargs
 local action=Actions_FontSize[fargs[1]]
 if action then
  local target=fargs[2]
  if target then
   action(target)
  end
 end
end
vim.api.nvim_create_user_command("FontResizer",FontResizer, {nargs="+"})

local setup = function(user_options)
 if user_options then
  options = vim.tbl_deep_extend("force",options,user_options)
 end
end

return {
 options=options,
 setup=setup,
}