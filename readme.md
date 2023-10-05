# fontresizer.nvim

A plugin for Neovim to resize the guifont.

## Installation

### With [Lazy](https://github.com/folke/lazy.nvim)

```lua
{"abcdefg233/fontresizer.nvim"}
```

### Settings

```lua
{
 "abcdefg233/fontresizer.nvim",
 init=function()
  require("fontresizer").setup({ --these are default settings
   default_size = 10,
     --Affects command :FontResizer Set Default
   change_up=1,
     --Affects command :FontResizer Change Up
   change_down=-1,
     --Affects command :FontResizer Change Down
   maximum = 30,
     --Size will not set higher than <maximum>
   minimum = 2,
     --Size will not set lower than <minimum>
     --Do not set a font size lower than 1
  })
 end,
}
```

## Usage

Use by commands

```lua
:FontResizer Change Up
  --Change font size by change_up
:FontResizer Change Down
  --Change font size by change_down
:FontResizer Change <num>
  --Change font size by <num>
:FontResizer Set Default
  --Set font size to default_size
:FontResizer Set <num>
  --Set font size to <num>
```

##Example

Use by shortcuts

```lua
vim.api.nvim_set_keymap("n","<A-Up>","<cmd>:FontResizer Change Up<CR>")
vim.api.nvim_set_keymap("n","<A-Down>","<cmd>:FontResizer Change Down<CR>")
vim.api.nvim_set_keymap("n","<A-0>","<cmd>:FontResizer Set Default<CR>")
vim.api.nvim_set_keymap("n","<C-ScrollWheelUp>","<cmd>:FontResizer Change Up<CR>")
vim.api.nvim_set_keymap("n","<C-ScrollWheelDown>","<cmd>:FontResizer Change Down<CR>")
```
