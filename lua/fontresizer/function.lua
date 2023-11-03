local Config=require("fontresizer.config")
local Error_set=require("fontresizer.error_set")
local M={}
local invalid_fontname={[""]=true,["*"]=true}
local function font_name_validate(font_name)
 if invalid_fontname[font_name] then
  Error_set.Font_name_Invalid(font_name)
 end
 return font_name
end
local function get_font_name()
 return font_name_validate(vim.o.guifont)
end
local function size_limit(size)
 local minimum=Config.options.minimum
 local maximum=Config.options.maximum
 if size>maximum then
  print("Size: "..size.." reached the boundary of maximum: "..maximum)
  return
 elseif size<minimum then
  print("Size: "..size.." reached the boundary of minimum: "..minimum)
  return
 end
 return size
end
local function ceil5floor(number)
 if number%1>0.5 then
  return math.ceil(number)
 else
  return math.floor(number)
 end
end
---@type integer
local font_size
---Support float font_size
---@type number
local font_size_raw
---@return number
local function get_font_size()
 local current_size=tonumber(string.match(get_font_name(),":h(%d*)")) or Config.options.default_size
 if current_size==font_size then
  return font_size_raw
 end
 return current_size
end
font_size=get_font_size()
font_size_raw=font_size
local function set_font_size(size)
 size=size_limit(size)
 if not size then return end
 font_size_raw=size
 size=ceil5floor(size)
 font_size=size
 local font_name=get_font_name()
 font_name=string.gsub(font_name,":h%d*",":h"..size)
 vim.rpcnotify(0,"Gui","Font",font_name,"!")
end
local function font_size_change(size)
 set_font_size(size+get_font_size())
end
local function font_size_set(size)
 set_font_size(size)
end
local Actions={}
Actions.Change={
 Up=function()
  font_size_change(Config.options.change_up)
 end,
 Down=function()
  font_size_change(Config.options.change_down)
 end,
}
Actions.Set={
 Default=function()
  font_size_set(Config.options.default_size)
 end,
}
Actions.FontResizer={
 Change=function(arg)
  local action=Actions.Change[arg]
  if action then
   action()
   return
  end
  local size=tonumber(arg)
  if size then
   font_size_change(size)
  end
 end,
 Set=function(arg)
  local action=Actions.Set[arg]
  if action then
   action()
   return
  end
  local size=tonumber(arg)
  if size then
   font_size_set(size)
  end
 end,
}
M.FontResizer=function(arg1,arg2)
 if not (arg1 and arg2) then return end
 local action=Actions.FontResizer[arg1]
 if action then
  action(arg2)
 end
end
M.Actions=Actions
return M