local HCUtil=require("hcutil")
local M={}
M.options={
 -- These are the default settings, not quite necessary.
 default_size=10,
 -- Affects command :FontResizer Set Default.
 change_up=1,
 -- Affects command :FontResizer Change Up.
 change_down=-1,
 -- Affects command :FontResizer Change Down.
 maximum=30,
 -- Font size will not sets higher than <maximum>.
 minimum=2,
 -- Font size will not sets lower than <minimum>.
 -- Please don't set the font size lower than 1, it seems broken.
 others={
  create_cmd=true,
  -- Create command "FontResizer" after setup.
  -- If use API, cmd may not necessary.
  create_var=true,
  -- Create Lua global variable "_G.FontResizer" after setup.
  create_api=true,
  -- Create a Module API after setup.
  -- require("fontresizr").API,
  -- If it sets false, you can still use
  -- require("fontresizr.api").
 },
}
local function number(arg)
 return type(arg)=="number"
end
local function integer(arg)
 return number(arg) and arg%1==0
end
M.setup=function(user_options)
 local opts=vim.tbl_deep_extend("force",M.options,user_options or {})
 HCUtil.validate_tab(opts,{
  default_size={function(arg) return integer(arg) and arg>0 end,"integer arg, 0<arg"},
  change_up   ="number",
  change_down ="number",
  maximum     ={function(arg) return number(arg) and arg>opts.minimum end,"integer arg, arg>minimum"},
  minimum     ={function(arg) return number(arg) and arg<opts.maximum end,"integer arg, arg<maximum"},
  others      ={
   create_cmd="boolean",
   create_var="boolean",
   create_api="boolean",
  },
 })
 M.options=opts
end
return M