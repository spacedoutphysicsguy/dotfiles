return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
  config = true,
  event = 'VeryLazy',
  keys = {
    -- Keymap to open the selector (e.g., Leader + v)
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
  },
}
