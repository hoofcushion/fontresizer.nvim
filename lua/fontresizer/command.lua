local HCUtil=require("hcutil")
local Config=require("fontresizer.config")
local Function=require("fontresizer.function")
local M={}
local registered=false
local FontResizer=function(cmd)
 Function.FontResizer(unpack(cmd.fargs))
end
local commands={
 {"FontResizer",FontResizer,{nargs="*"}},
}
function M.setup()
 local create_cmd=Config.options.others.create_cmd
 if create_cmd~=registered then
  if registered==false then
   HCUtil.create_user_commands(commands)
   registered=true
  end
 else
  if registered==true then
   HCUtil.del_user_commands(commands)
   registered=false
  end
 end
end
return M
