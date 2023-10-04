local colors = require("electron_highlighter.colors").setup({ transform = true })
local config = require("electron_highlighter.config").options

local electron_highlighter = {}

electron_highlighter.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.blue },
  c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
}

electron_highlighter.insert = {
  a = { bg = colors.teal, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.teal },
}

electron_highlighter.command = {
  a = { bg = colors.orange, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.orange },
}

electron_highlighter.visual = {
  a = { bg = colors.magenta, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.magenta },
}

electron_highlighter.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.red },
}

electron_highlighter.terminal = {
  a = {bg = colors.green1, fg = colors.black },
  b = {bg = colors.fg_gutter, fg=colors.green1 },
}

electron_highlighter.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
}

if config.lualine_bold then
  for _, mode in pairs(electron_highlighter) do
    mode.a.gui = "bold"
  end
end

return electron_highlighter
