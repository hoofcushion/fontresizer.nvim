local M={loaded=false}
local Config=require("fontresizer.config")
local function setup(user_options)
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
function M.setup(user_options)
 if M.loaded then
  setup(user_options)
 else
  vim.api.nvim_create_autocmd("WinEnter",{once=true,callback=function() setup(user_options) end})
 end
end
M.options=Config.options
return M