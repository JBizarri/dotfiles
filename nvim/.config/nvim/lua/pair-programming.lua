_G.PairProgrammingMode = false

vim.keymap.set('n', '<leader>tp', function()
  _G.PairProgrammingMode = not _G.PairProgrammingMode

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    vim.api.nvim_set_option_value('relativenumber', not _G.PairProgrammingMode, { win = win })
  end

  local msg = _G.PairProgrammingMode and 'Pair Programming mode: ON (absolute numbers)' or 'Pair Programming mode: OFF (relative numbers)'
  vim.notify(msg)
end, { desc = '[T]oggle [P]air programming mode' })

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'BufEnter', 'BufReadPost' }, {
  callback = function()
    vim.schedule(function()
      if _G.PairProgrammingMode then
        vim.wo.relativenumber = false
      else
        vim.wo.relativenumber = true
      end
    end)
  end,
})
