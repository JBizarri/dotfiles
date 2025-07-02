return {
  'stevanmilic/nvim-lspimport',
  config = function()
    vim.keymap.set('n', '<leader>i', require('lspimport').import, { desc = 'Resolve [I]mport', noremap = true })
  end,
}
