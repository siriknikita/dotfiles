-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move down <C-d>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Move up <C-e>
vim.keymap.set("n", "<C-e>", "<C-u>zz")
