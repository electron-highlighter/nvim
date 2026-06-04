-- Run: nvim --headless -u NONE --cmd "set rtp+=." -c "luafile tests/day_spec.lua" -c "qa"
local function hl(group, attr)
  local h = vim.api.nvim_get_hl(0, { name = group, link = false })
  local v = h[attr]
  return v and string.format("#%06x", v) or nil
end

require("electron_highlighter").setup({ style = "day" })
require("electron_highlighter").load({ style = "day" })

local checks = {
  -- vim.o.background must be set to "light" by the day variant
  { "vim.o.background", vim.o.background, "light" },
  -- Normal: fg = c.fg (#2f3b54), bg = c.bg (#eef0f5)
  { "Normal.bg", hl("Normal", "bg"), "#eef0f5" },
  { "Normal.fg", hl("Normal", "fg"), "#2f3b54" },
  -- Comment: fg = c.comment (#7b88a8)
  { "Comment.fg", hl("Comment", "fg"), "#7b88a8" },
  -- String: fg = c.green (#10a877)
  { "String.fg", hl("String", "fg"), "#10a877" },
  -- Constant: fg = c.orange (#f0633c)
  { "Constant.fg", hl("Constant", "fg"), "#f0633c" },
  -- Operator: fg = c.cyan (#0a9fbf)
  { "Operator.fg", hl("Operator", "fg"), "#0a9fbf" },
  -- Tag: fg = c.red (#f52a65)
  { "Tag.fg", hl("Tag", "fg"), "#f52a65" },
}

local failed = 0
for _, c in ipairs(checks) do
  local name, got, want = c[1], c[2], c[3]
  if got ~= want then
    failed = failed + 1
    print(string.format("FAIL %s: got %s want %s", name, tostring(got), want))
  else
    print(string.format("ok   %s = %s", name, want))
  end
end
print(failed > 0 and ("DAY SPEC FAILED: " .. failed) or "DAY SPEC PASSED")
