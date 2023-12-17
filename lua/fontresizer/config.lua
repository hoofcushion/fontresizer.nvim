local HCUtil=require("hcutil")
local M={}
M.options={
 default_size=10,
 change_up=1,
 change_down=-1,
 maximum=30,
 minimum=2,
 others={
  create_cmd=true,
  create_var=true,
  create_api=true,
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
 HCUtil.Validate.tab(opts,{
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
