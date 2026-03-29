return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash', 'lua', 'luadoc', 'vim', 'vimdoc',
      'diff', 'markdown', 'markdown_inline', 'query',
      'html', 'css', 'javascript', 'typescript',
      'python', 'c', 'go',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
