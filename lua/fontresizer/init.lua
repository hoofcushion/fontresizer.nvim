local options={
 default_size=10,
 change_up=1,
 change_down=-1,
 maximum=30,
 minimum=2,
}
local function get_size_now()
 return tonumber(string.match(vim.opt.guifont._value,":h(%d+)"))
end
local function set_font_size(size)
 size=tostring(size)
 vim.rpcnotify(0,"Gui","Font",string.gsub(vim.opt.guifont._value,":h%d+",":h"..size),"!")
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
 end,
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
local function fnFontResizer(arg1,arg2)
 if not (arg1 and arg2) then return end
 local action=Actions_FontSize[arg1]
 if action then
  local target=arg2
  if target then
   action(target)
  end
 end
end
local function cmdFontResizer(cmd)
 local fargs=cmd.fargs
 fnFontResizer(fargs[1],fargs[2])
end

local setup=function(user_options)
 if vim.g.FontResizer==nil then
  vim.api.nvim_create_user_command("FontResizer",cmdFontResizer,{nargs="+"})
  local G_FontResizer={}
  if type(user_options)=="table" then
   G_FontResizer.options=vim.tbl_deep_extend("force",options,user_options)
  end
  vim.g.FontResizer=G_FontResizer
  return
 end
 local G_FontResizer=vim.g.FontResizer
 if type(user_options)=="table" then
  G_FontResizer.options=vim.tbl_deep_extend("force",G_FontResizer.options,user_options)
 end
end
return {
 FontResizer=fnFontResizer,
 options=options,
 setup=setup,
}