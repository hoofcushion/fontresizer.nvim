local HCUtil=require("hcutil")
local M={}
M.options={
 fontresizer={
  default_size=10,
  default_font="",
  change_up=1,
  change_down=-1,
  maximum=30,
  minimum=2,
 },
 others={
  create_cmd=true,
  create_var=true,
  create_api=true,
 },
}
local function number(x)
 return type(x)=="number"
end
local function integer(x)
 return number(x) and x%1==0
end
local valitab={
 fontresizer={
  default_size=function(x) return integer(x) and x>0,"integer arg, 0<arg" end,
  default_font=HCUtil.Validate.mk_union("string","nil"),
  change_up   ="number",
  change_down ="number",
 },
 others     ={
  create_cmd="boolean",
  create_var="boolean",
  create_api="boolean",
 },
}
M.setup=function(user_options)
 local opts=vim.tbl_deep_extend("force",M.options,user_options or {})
 HCUtil.Validate.vali(opts,valitab,"Fontresizer.options")
 valitab.fontresizer.maximum=function(x) return number(x) and x>opts.minimum,"integer arg, arg>minimum" end
 valitab.fontresizer.minimum=function(x) return number(x) and x<opts.maximum,"integer arg, arg<maximum" end
 M.options=opts
end
return M
