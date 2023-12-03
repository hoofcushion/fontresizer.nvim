local M={loaded=false}
local Config=require("fontresizer.config")
M.options=Config.options
function M.setup(user_options)
 Config.setup(user_options)
 local others=Config.options.others
 if others.create_cmd==true then
  require("fontresizer.command").setup()
 end
 if others.create_var==true then
  _G.FontResizer=M
 end
 if others.create_api==true then
  M.API=require("fontresizer.api")
 end
 M.loaded=true
end
return M