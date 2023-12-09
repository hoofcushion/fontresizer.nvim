local Config=require("fontresizer.config")
local Command=require("rainbowcursor.command")
local M={}
M.options=Config.options
function M.setup(user_options)
 Config.setup(user_options)
 Command.setup()
 local opts=Config.options
 if opts.others.create_var then
  _G.RainbowCursor=M
 else
  _G.RainbowCursor=nil
 end
 if opts.others.create_api then
  M.API=require("fontresizer.api")
 else
  M.API=nil
 end
end
return M