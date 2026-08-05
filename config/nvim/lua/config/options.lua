-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim defaults this to "unnamedplus", which syncs ALL yank/delete/change
-- operations (y, d, x, c) to the system clipboard. Disable that blanket sync;
-- keymaps.lua remaps only y/d explicitly instead, so x/c stay local.
vim.opt.clipboard = ""
