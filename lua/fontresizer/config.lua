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
M.setup=function(user_options)
 vim.validate({user_options={user_options,"table"}})
 local opts=vim.tbl_deep_extend("force",M.options,user_options or {})
 vim.validate({opts={opts,"table"}})
 vim.validate({
  default_size={opts.default_size,"number"},
  change_up   ={opts.change_up,"number"},
  change_down ={opts.change_down,"number"},
  maximum     ={opts.maximum,"number"},
  minimum     ={opts.minimum,"number"},
  others      ={opts.others,"table"},
 })
 vim.validate({
  create_cmd  ={opts.others.create_cmd,"boolean"},
  create_var  ={opts.others.create_var,"boolean"},
  create_api  ={opts.others.create_api,"boolean"},
 })
 M.options=opts
end
return M