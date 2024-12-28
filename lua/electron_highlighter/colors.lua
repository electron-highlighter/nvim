local util = require("electron_highlighter.util")

local M = {}

---@class Palette
M.default = {
  none = "NONE",
  bg = "#24283b",
  bg_dark = "#1f2335",
  bg_highlight = "#37435C",
  terminal_black = "#414868",
  fg = "#a8b5d1",
  fg_dark = "#99a3b8",
  fg_gutter = "#3b4261",
  comment = "#506686",
  blue = "#82aaff",
  cyan = "#4ff2f8",
  orange = "#ffd9af",
  yellow = "#fffa9e",
  green = "#34febb",
  red = "#f7768e",
  git = {
    add = "#10b981",
    change = "#ff9e64",
    delete = "#f7768e",
  },
  gitSigns = {
    add = "#10b981",
    change = "#ff9e64",
    delete = "#f7768e"
  },
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  blue0 = "#3d59a1",
  blue1 = "#22d3ee",
  blue2 = "#06b6d4",
  blue5 = "#7dd3fc",
  blue6 = "#a5f3fc",
  blue7 = "#375574",
  magenta = "#c792ea",
  magenta2 = "#ff007c",
  teal = "#14b8a6",
  green1 = "#10b981",
  green2 = "#059669",
  red1 = "#ff5874",
}

M.night = {
  none = "NONE",
  bg = "#1b212c",
  bg_dark = "#141820",
  bg_highlight = "#37435C",
  terminal_black = "#414868",
  fg = "#a8b5d1",
  fg_dark = "#99a3b8",
  fg_gutter = "#3b4261",
  comment = "#506686",
  blue = "#82aaff",
  cyan = "#4ff2f8",
  orange = "#ffd9af",
  yellow = "#fffa9e",
  green = "#34febb",
  red = "#f7768e",
  git = {
    change = "#ff9e64",
    add = "#10b981",
    delete = "#f7768e",
  },
  gitSigns = {
    add = "#10b981",
    change = "#ff9e64",
    delete = "#f7768e"
  },
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  blue0 = "#3d59a1",
  blue1 = "#22d3ee",
  blue2 = "#06b6d4",
  blue5 = "#7dd3fc",
  blue6 = "#a5f3fc",
  blue7 = "#375574",
  magenta = "#c792ea",
  magenta2 = "#ff007c",
  teal = "#14b8a6",
  green1 = "#10b981",
  green2 = "#059669",
  red1 = "#ff5874",
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("electron_highlighter.config")

  local style = config.options.style
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.diff = {
    add = util.darken(colors.green2, 0.15),
    delete = util.darken(colors.red1, 0.15),
    change = util.darken(colors.blue7, 0.15),
    text = colors.blue7,
  }

  colors.git.ignore = colors.dark3
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = util.darken(colors.blue1, 0.8)
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
      or config.options.styles.sidebars == "dark" and colors.bg_dark
      or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
      or config.options.styles.floats == "dark" and colors.bg_dark
      or colors.bg
  colors.bg_visual = util.darken(colors.blue0, 0.4)
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  -- colors.fg_float = config.options.styles.floats == "dark" and colors.fg_dark or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red1
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal

  colors.delta = {
    add = util.darken(colors.green2, 0.45),
    delete = util.darken(colors.red1, 0.45),
  }

  config.options.on_colors(colors)
  return colors
end

return M
