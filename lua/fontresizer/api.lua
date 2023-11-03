local Function=require("fontresizer.function")
local M={}
M.FontResizer=Function.FontResizer
M.Set        =Function.Actions.FontResizer.Set
M.Change     =Function.Actions.FontResizer.Change
M.Change_Up  =Function.Actions.Change.Up
M.Change_Down=Function.Actions.Change.Down
M.Set_Default=Function.Actions.Set.Default
return M