-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--local function fix_spellbad()
--  vim.api.nvim_set_hl(0, "SpellBad", { underline = true })
--end
--
---- reapply on any future colorscheme switch
--vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_spellbad })
--
---- and apply once now, since the colorscheme is already loaded when this file runs
--fix_spellbad()

-- High-contrast diff highlights, pulled live from the active catppuccin
-- palette instead of hardcoded hex, so switching catppuccin flavors
-- (mocha/macchiato/frappe/latte) stays in sync automatically.
-- Reverse-video style: colored background, base-toned text on top. Also
-- colors the filler/placeholder alignment lines that diffview's
-- enhanced_diff_hl (lua/plugins/diffview.lua) otherwise dims to grey.
local function set_diff_colors()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if not ok then return end
  local C = palettes.get_palette()
  local colors = require("catppuccin.utils.colors")
  -- DiffChange spans whole hunk blocks (context lines included), not just a
  -- single edited line, so it only gets a background tint -- no forced fg --
  -- to keep each line's own syntax highlighting legible underneath.
  local change_bg = colors.darken(C.blue, 0.20, C.base)

  local hi = vim.api.nvim_set_hl
  hi(0, "DiffAdd", { bg = C.green, fg = C.base, bold = true })
  hi(0, "DiffDelete", { bg = C.red, fg = C.base, bold = true })
  hi(0, "DiffChange", { bg = change_bg })
  hi(0, "DiffText", { bg = C.yellow, fg = C.base, bold = true })

  -- diffview-specific groups (only active because enhanced_diff_hl = true)
  hi(0, "DiffviewDiffAdd", { bg = C.green, fg = C.base, bold = true })
  hi(0, "DiffviewDiffAddAsDelete", { bg = C.red, fg = C.base, bold = true })
  hi(0, "DiffviewDiffDeleteDim", { bg = C.red, fg = C.base })
  hi(0, "DiffviewDiffChange", { bg = change_bg })
  hi(0, "DiffviewDiffText", { bg = C.yellow, fg = C.base, bold = true })
end

-- reapply whenever a catppuccin flavor (re)loads
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "catppuccin*", callback = set_diff_colors })

-- and apply once now, since the colorscheme is already loaded when this file runs
set_diff_colors()

-- Allow control-click behavior for opening links within Markdown. Note gx works, too.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.keymap.set("n", "<C-LeftMouse>", function()
      vim.cmd("normal! gx")
    end, { buffer = args.buf, desc = "Open link under mouse click" })
  end,
})
