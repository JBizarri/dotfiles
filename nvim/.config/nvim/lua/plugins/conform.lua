return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters = {
        ruff_fix = {
          command = 'ruff',
          args = {
            'check',
            '--fix',
            '--ignore',
            'F401',
            '--stdin-filename',
            '$FILENAME',
            '-',
          },
          stdin = true,
        },
        prettier = {
          prepend_args = {
            '--tab-width',
            '4',
          },
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = {
          'ruff_fix',
          'ruff_format',
          'ruff_organize_imports',
        },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        -- Conform can also run multiple formatters sequentially
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
