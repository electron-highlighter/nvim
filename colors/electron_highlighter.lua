local style = vim.env.CURRENT_THEME == "electron_highlighter_day" and "day" or nil
require("electron_highlighter")._load(style)
