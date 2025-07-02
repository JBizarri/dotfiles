-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Add new blank line below cursor
vim.keymap.set('n', '<Enter>', 'o<Esc>')

vim.keymap.set('n', '<leader>T', '<cmd>tabnew<CR>', { desc = 'Open new [T]ab' })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete without copying' })

vim.keymap.set('n', 'c<leader>w', "c<cmd>lua require('spider').motion('e')<CR>", { desc = 'Next subword' })
vim.keymap.set({ 'n', 'o', 'x' }, '<leader>w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Next subword' })
vim.keymap.set({ 'n', 'o', 'x' }, '<leader>e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Next end of subword' })
vim.keymap.set({ 'n', 'o', 'x' }, '<leader>b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Prev word' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.keymap.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
  print('Copied path: ' .. vim.fn.expand '%:p')
end, { desc = '[C]opy Absolute File [P]ath' })

vim.keymap.set('n', '<leader>cr', function()
  vim.fn.setreg('+', vim.fn.expand '%')
  print('Copied path: ' .. vim.fn.expand '%')
end, { desc = '[C]opy [R]elative File Path' })
-- vim: ts=2 sts=2 sw=2 et
