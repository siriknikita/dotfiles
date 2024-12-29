vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.g.have_nerd_font = false

vim.opt.number = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamed'
end)

vim.opt.breakindent = true

vim.opt.guicursor = ''

vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'

vim.opt.colorcolumn = '79'

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = 'Move to the window on the left' })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = 'Move to the window below' })
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = 'Move to the window above' })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = 'Move to the window on the right' })

vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>', { desc = 'Move to the next quickfix item' })
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>', { desc = 'Move to the previous quickfix item' })

-- Save file and quit
vim.keymap.set('n', '<leader>w', '<cmd>update<CR>', { desc = '[W]rite changes to file' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>', { desc = '[Q]uit' })

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open [P]ackage [V]iew' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
