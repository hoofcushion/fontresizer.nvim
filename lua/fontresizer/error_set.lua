local M={
 Font_name_Invalid=function(fontname)
  error("The font name \""..fontname.."\" is invalid.\nPlease specify a guifont first `:set guifont=<fontname>:h<size>`.\n or Try use Neovim-qt")
 end,
 Options_Invalid=function()
  error("The options is invalid")
 end,
}
return M