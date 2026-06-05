# Electron Highlighter for Neovim

A dark and light Neovim theme written in Lua ported from the excellent
[TokyoNight](https://github.com/folke/tokyonight.nvim) theme.

## Screenshot

![image](/screenshot.jpg)

## ✨ Features

- supports the latest Neovim 0.9.0 features
- terminal colors
- darker background for sidebar-like windows
- light `day` variant (a light background, for daytime/light-mode use)
- supports all major plugins

## ⚡️ Requirements

- Neovim >= 0.7.2

## 📦 Installation

Install the theme with your preferred package manager:

[folke/lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "electron-highlighter/nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}
```

## 🚀 Usage

Enable the colorscheme:

```vim
" Vim Script
colorscheme electron_highlighter
```

```lua
-- Lua
vim.cmd[[colorscheme electron_highlighter]]
```

To enable the `electron_highlighter` theme for `Barbecue`:

```lua
require('barbecue').setup {
  -- ... your barbecue config
  theme = 'electron_highlighter',
  -- ... your barbecue config
}
```

To enable the `electron_highlighter` theme for `Lualine`, simply specify it in your
lualine settings:

```lua
require('lualine').setup {
  options = {
    -- ... your lualine config
    theme = 'electron_highlighter'
    -- ... your lualine config
  }
}
```

To enable the `electron_highlighter` colorscheme for `Lightline`:

```vim
" Vim Script
let g:lightline = {'colorscheme': 'electron_highlighter'}
```

## ⚙️ Configuration

> ❗️ configuration needs to be set **BEFORE** loading the color scheme with
> `colorscheme electron_highlighter`

The theme comes in three styles: the default (dark), a darker variant `night`, and a
light variant `day`. Selecting `day` also switches Neovim to a light background
(`vim.o.background = "light"`).

```lua
-- Light variant:
require("electron_highlighter").setup({ style = "day" })
vim.cmd.colorscheme("electron_highlighter")
```

Tip: if your shell exports the current OS/terminal theme (e.g. `CURRENT_THEME`), you can
follow it automatically:

```lua
require("electron_highlighter").setup({
  style = (os.getenv("CURRENT_THEME") == "electron_highlighter_day") and "day" or "default",
})
vim.cmd.colorscheme("electron_highlighter")
```

Electron Highlighter will use the default options, unless you call `setup`.

```lua
require("electron_highlighter").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})
```

## 🪓 Overriding Colors & Highlight Groups

How the highlight groups are calculated:

1. the **colors** for the style are calculated based on your config
2. `config.on_colors(colors)` is ran, where you can override the colors
3. the **colors** are then used to generate the highlight groups
4. `config.on_highlights(highlights, colors)` is ran, where you can overide the highlight groups


Example for changing some settings and colors

```lua
require("electron_highlighter").setup({
  -- use the night style
  style = "night",
  -- disable italic for functions
  styles = {
    functions = {}
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end
})
```

Example to make Telescope
[borderless](https://github.com/nvim-telescope/telescope.nvim/wiki/Gallery#borderless)

```lua
require("electron_highlighter").setup({
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
})
```

### Making `undercurls` work properly in **Tmux**

To have undercurls show up and in color, add the following to your **Tmux**
config file:

```sh
# Undercurl
set -g default-terminal "${TERM}"
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
```
