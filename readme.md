# fontresizer.nvim

A plugin for Neovim to resize the guifont.

## Demo

https://github.com/hoofcushion/fontresizer.nvim/assets/32760059/7da96868-019f-49da-ae33-ca40f7155b53

## Important

This plugin is only for Neovim gui client like Neovim-qt

## Installation

With [Lazy](https://github.com/folke/lazy.nvim)

```lua
local spec = {
 "hoofcushion/fontresizer.nvim",
 cmd = { "FontResizer" },
 opts = {},
 dependencies = {
  "hoofcushion/hcutil.nvim",
 },
}
```

## Configuration

```lua
local spec = {
 "hoofcushion/fontresizer.nvim",
 cmd = { "FontResizer" },
 opts = {
  fontresizer = {
   -- These are the default settings, not quite necessary.
   default_size = 10,
   -- Affects command :FontResizer Set Default.
   default_font = nil, -- string
   -- Set font after plugin setup.
   change_up = 1,
   -- Affects command :FontResizer Change Up.
   change_down = -1,
   -- Affects command :FontResizer Change Down.
   maximum = 30,
   -- Affects command :FontResizer Set Maximum.
   -- Font size will not sets higher than <maximum>.
   minimum = 2,
   -- Affects command :FontResizer Set Minimum.
   -- Font size will not sets lower than <minimum>.
   -- Please don't set the font size lower than 1, it seems broken.
  },
  others = {
   create_cmd = true,
   -- Create command "FontResizer" after setup.
   -- If use API, cmd may not necessary.
   create_var = true,
   -- Create Lua global variable "_G.FontResizer" after setup.
   create_api = true,
   -- Create a Module API after setup.
   -- require("fontresizr").API,
   -- If it sets false, you can still use
   -- require("fontresizr.api").
  },
  dependencies = {
   "hoofcushion/hcutil.nvim",
  },
 },
}
```

## Usage

Lua API

```lua
-- You can get the API by these following ways.
-- If you do not like Lua way, you can disable API
-- by setting *others.create_var and *others.create_api to false,
-- and use command instead.

local API = require("fontresizr.api")
-- Works but not elegant.

local API = require("fontresizr").API
-- Needs *others.create_api==true.

local API = _G.FontResizer.API
-- Needs *others.create_api==true.
-- Needs *others.create_var==true.
```

```lua
_G.FontResizer.API.Change_Up()
-- Change font size by *change_up
_G.FontResizer.API.Change_Down()
-- Change font size by *change_down
_G.FontResizer.API.Change(number)
-- Change font size by number
-- - Positive number increases font size
-- - Negative number decreases font size
_G.FontResizer.API.Set_Default()
-- Set font size to *default_size
_G.FontResizer.API.Set(number)
-- Set font size to number
```

Commands

If `*others.create_cmd==true`, you will get a command `FontResizer` after setup.

You can use it in these following terms

| Commands                    | Behaviors                                                                                      |
| :-------------------------- | :--------------------------------------------------------------------------------------------- |
| FontResizer Change Up       | Change font size by \*change_up                                                                |
| FontResizer Change Down     | Change font size by \*change_down                                                              |
| FontResizer Set Default     | Set font size to \*default_size                                                                |
| FontResizer Change `number` | Change font size by `number`, positive `number` will increase, negative `number` will decrease |
| FontResizer Set `number`    | Set font size to `number`                                                                      |

Default Commands

```
FontResizer Change Up
FontResizer Change Down
FontResizer Set Default
```

### Use by shortcuts

Normal mapping

```lua
local keys = {
 [{ "n" }] = {
  {
   "<A-Up>",
   function()
    _G.RainbowCursor.API.Change_Up()
   end,
   "RainbowCursor Change Up",
  },
  {
   "<A-Down>",
   function()
    _G.RainbowCursor.API.Change_Down()
   end,
   "RainbowCursor Change Down",
  },
  {
   "<A-0>",
   function()
    _G.RainbowCursor.API.Set_Default()
   end,
   "RainbowCursor Set Default",
  },
 },
 [{ "n", "s", "x", "o", "i", "c", "t" }] = {
  {
   "<C-ScrollWheelUp>",
   function()
    _G.RainbowCursor.API.Change_Up()
   end,
   "RainbowCursor Change Up",
  },
  {
   "<C-ScrollWheelDown>",
   function()
    _G.RainbowCursor.API.Change_Down()
   end,
   "RainbowCursor Change Down",
  },
  {
   "<C-MiddleMouse>",
   function()
    _G.RainbowCursor.API.Set_Default()
   end,
   "RainbowCursor Set Default",
  },
 },
}
local default_opts = { noremap = true, silent = true }
for modes, key in pairs(keys) do
 local opts = default_opts
 opts.desc = key[3]
 vim.keymap.set(modes, key[1], key[2], opts)
end
```

Lazy keys

```lua
local keys = {
 {
  "<A-Up>",
  function()
   _G.FontResizer.API.Change_Up()
  end,
  desc = "FontResizer Change Up",
 },
 {
  "<A-Down>",
  function()
   _G.FontResizer.API.Change_Down()
  end,
  desc = "FontResizer Change Down",
 },
 {
  "<A-0>",
  function()
   _G.FontResizer.API.Set_Default()
  end,
  desc = "FontResizer Set Default",
 },
 {
  "<C-ScrollWheelUp>",
  function()
   _G.FontResizer.API.Change_Up()
  end,
  mode = { "n", "s", "x", "o", "i", "c", "t" },
  desc = "FontResizer Change Up",
 },
 {
  "<C-ScrollWheelDown>",
  function()
   _G.FontResizer.API.Change_Down()
  end,
  mode = { "n", "s", "x", "o", "i", "c", "t" },
  desc = "FontResizer Change Down",
 },
 {
  "<C-MiddleMouse>",
  function()
   _G.FontResizer.API.Set_Default()
  end,
  mode = { "n", "s", "x", "o", "i", "c", "t" },
  desc = "FontResizer Set Default",
 },
}
```

## Example Configuration

Convenient setup for lazy.nvim users

```lua
local spec = {
 "hoofcushion/fontresizer.nvim",
 cmd = { "FontResizer" },
 -- keys = {
 --  Use the lazy keys above, if you want.
 -- },
 opts = {
  default_size = 10,
  change_up = 1,
  change_down = -1,
  maximum = 30,
  minimum = 2,
  others = {
   create_cmd = true,
   create_var = true,
   create_api = true,
  },
 },
 dependencies = {
  "hoofcushion/hcutil.nvim",
 },
}
```

Modularize

```lua
local M = {}
M[1] = "hoofcushion/fontresizer.nvim"
M.cmd = { "FontResizer" }
-- M.keys = {
--  Use the lazy keys above, if you want.
-- }
M.opts = {
 default_size = 10,
 change_up = 1,
 change_down = -1,
 maximum = 30,
 minimum = 2,
 others = {
  create_cmd = true,
  create_var = true,
  create_api = true,
 },
}
M.dependencies = {
 "hoofcushion/hcutil.nvim",
}
return M
```
