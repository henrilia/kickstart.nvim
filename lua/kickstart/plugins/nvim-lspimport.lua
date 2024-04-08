return {
  'stevanmilic/nvim-lspimport',

  config = function()
    vim.keymap.set('n', '<leader>a', function()
      if vim.bo.filetype == 'python' then
        require('lspimport').import()
      else
        vim.lsp.buf.code_action()
      end
    end, { noremap = true })
  end,
}
