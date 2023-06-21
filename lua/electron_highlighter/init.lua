local util = require("electron_highlighter.util")
local theme = require("electron_highlighter.theme")
local config = require("electron_highlighter.config")

local M = {}

function M._load(style)
  M.load({ style = style, use_background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
  if opts then
    require("electron_highlighter.config").extend(opts)
  end
  util.load(theme.setup())
end

M.setup = config.setup

-- keep for backward compatibility
M.colorscheme = M.load

return M
