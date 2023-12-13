local M={}
function M.setup(user_options)
 local Config=require("fontresizer.config")
 local Command=require("fontresizer.command")
 Config.setup(user_options)
 Command.setup()
 if Config.options.others.create_var==true then
  _G.FontResizer=M
 elseif _G.FontResizer~=nil then
  _G.FontResizer=nil
 end
 if Config.options.others.create_api==true then
  M.API=require("fontresizer.api")
 elseif M.API~=nil then
  M.API=nil
 end
end
return M
