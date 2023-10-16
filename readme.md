# fontresizer.nvim
A plugin for Neovim to resize the guifont.

### Demo
https://github.com/abcdefg233/fontresizer.nvim/assets/32760059/7da96868-019f-49da-ae33-ca40f7155b53
## Installation

With [Lazy](https://github.com/folke/lazy.nvim)

```lua
{"abcdefg233/fontresizer.nvim"}
```

Configuration

```lua
{
  "abcdefg233/fontresizer.nvim",
  init=function()
    require("fontresizer").setup(
      -- These are the default settings, not quite necessary.
      {
      default_size = 10,
        -- Affects command :FontResizer Set Default
      change_up=1,
        -- Affects command :FontResizer Change Up
      change_down=-1,
        -- Affects command :FontResizer Change Down
      maximum = 30,
        -- Font size will not sets higher than <maximum>
      minimum = 2,
        -- Font size will not sets lower than <minimum>
        -- Please don't set the font size lower than 1, it seems broken.
      }
    )
  end,
}
```

## Usage

Use by commands

```lua
:FontResizer Change Up
  -- Change font size by change_up
:FontResizer Change Down
  -- Change font size by change_down
:FontResizer Change <number>
  -- Change font size by <num>
  -- - Positive <num> increases font size
  -- - Negative <num> decreases font size
:FontResizer Set Default
  -- Set font size to default_size
:FontResizer Set <num>
  -- Set font size to <num>
```

Use by shortcuts

```lua
-- Binding keymap
local opts = {noremap = true,silent = true}
vim.api.nvim_set_keymap("n","<A-Up>","<cmd>:FontResizer Change Up<CR>",opts)
  -- Alt + Up → Change Up
vim.api.nvim_set_keymap("n","<A-Down>","<cmd>:FontResizer Change Down<CR>",opts)
  -- Alt + Down → Change Down
vim.api.nvim_set_keymap("n","<A-0>","<cmd>:FontResizer Set Default<CR>",opts)
  -- Alt + 0 → Set Default
vim.api.nvim_set_keymap("n","<C-ScrollWheelUp>","<cmd>:FontResizer Change Up<CR>",opts)
  -- Ctrl + ScrollWheelUp → Change Up
vim.api.nvim_set_keymap("n","<C-ScrollWheelDown>","<cmd>:FontResizer Change Down<CR>",opts)
  -- Ctrl + ScrollWheelDown → Change Down
vim.api.nvim_set_keymap("n","<C-MiddleMouse>","<cmd>:FontResizer Change Down<CR>",opts)
```

## Example Configuration

Convenient setup

```lua
{
  "abcdefg233/fontresizer.nvim",
  init=function()
    require("fontresizer").setup(
      -- These are the default settings, not quite necessary.
      {
      default_size = 10,
        -- Affects command :FontResizer Set Default
      change_up=1,
        -- Affects command :FontResizer Change Up
      change_down=-1,
        -- Affects command :FontResizer Change Down
      maximum = 30,
        -- Font size will not sets higher than <maximum>
      minimum = 2,
        -- Font size will not sets lower than <minimum>
        -- Please don't set the font size lower than 1, it seems broken.
      }
    )
    -- Binding keymap
     local opts = {noremap = true,silent = true}
     vim.api.nvim_set_keymap("n","<A-Up>","<cmd>:FontResizer Change Up<CR>",opts)
       -- Alt + Up → Change Up
     vim.api.nvim_set_keymap("n","<A-Down>","<cmd>:FontResizer Change Down<CR>",opts)
       -- Alt + Down → Change Down
     vim.api.nvim_set_keymap("n","<A-0>","<cmd>:FontResizer Set Default<CR>",opts)
       -- Alt + 0 → Set Default
     vim.api.nvim_set_keymap("n","<C-ScrollWheelUp>","<cmd>:FontResizer Change Up<CR>",opts)
       -- Ctrl + ScrollWheelUp → Change Up
     vim.api.nvim_set_keymap("n","<C-ScrollWheelDown>","<cmd>:FontResizer Change Down<CR>",opts)
       -- Ctrl + ScrollWheelDown → Change Down
     vim.api.nvim_set_keymap("n","<C-MiddleMouse>","<cmd>:FontResizer Change Down<CR>",opts)
 end,
}
```
