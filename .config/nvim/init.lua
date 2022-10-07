require 'visimp' {
  autopairs = {},
  defaults = {
    colorcolumn = 0,
    foldmethod = 'marker',
  },
  binds = {
    [{ mode = 'n', bind = '<C-Tab>'}] = ':bprev',
    [{ mode = 'n', bind = '<C-S-Tab>'}] = ':bnext'
  },
  lsp = {
    nullls = {
      'formatting.stylua',
      'formatting.prettier',
      'formatting.latexindent',
    },
  },
  languages = {
    'c',
    'latex',
--  'lua',
    'javascript',
    'html',
    'css',
    'json',
    'vue',
--    'go',
--    'rust'
  },
  --alternatives: jacoborus/tender.vim
  --patstockwell/vim-monokai-tasty
  --
  theme = {
    package = 'ray-x/aurora',
    colorscheme = 'aurora',
    background = 'dark',
    lualine = 'aurora',
    before = function()
      vim.g.aurora_transparent = 1
    end
  },
}
