local Function=require("fontresizer.function")
local M={}
M.FontResizer=function(cmd)
 local fargs=cmd.fargs
 Function.FontResizer(fargs[1],fargs[2])
end
M.setup=function()
 if M.loaded then return end
 M.loaded=true
 vim.api.nvim_create_user_command("FontResizer",M.FontResizer,{nargs="+"})
end
return M