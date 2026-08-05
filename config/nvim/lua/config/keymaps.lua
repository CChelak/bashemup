-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Route only yank/delete through the system clipboard ("+ register).
-- Cut (x) and change (c) are intentionally left unmapped, so they keep
-- using the local unnamed register instead of clobbering the clipboard.
local map = vim.keymap.set
map({ "n", "v" }, "y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "Y", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "d", '"+d', { desc = "Delete to system clipboard" })
map({ "n", "v" }, "D", '"+D', { desc = "Delete to end of line to system clipboard" })
