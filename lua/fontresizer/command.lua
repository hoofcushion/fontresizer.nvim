local HCUtil=require("hcutil")
local Config=require("fontresizer.config")
local Function=require("fontresizer.function")
local M={}
local registered=false
local FontResizer=function(cmd)
 Function.FontResizer(unpack(cmd.fargs))
end
local completions={
 FontResizer={
  {
   {"Change","Set"},
  },
  Change={{
   {"Up","Down"},
  }},
  Set={{
   {"Default","Maximum","Minimum"},
  }},
 },
}
local function complete(_,CmdLine)
 local cmp=completions
 for arg in string.gmatch(CmdLine,"%S+") do
  if cmp[arg] then cmp=cmp[arg] else return nil end
 end
 if cmp[1].func then cmp[1]:func() end
 return cmp[1][1]
end
local commands={
 {"FontResizer",FontResizer,{nargs="*",complete=complete}},
}
function M.setup()
 if registered~=Config.options.others.create_cmd then
  if registered==false then
   HCUtil.create_user_commands(commands)
  else
   HCUtil.del_user_commands(commands)
  end
  registered=Config.options.others.create_cmd
 end
end
return M
