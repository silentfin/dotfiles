vim.pack.add {
    'https://github.com/NMAC427/guess-indent.nvim',
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/folke/which-key.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-tree/nvim-tree.lua',
    'https://github.com/nvim-tree/nvim-web-devicons',
}

require('guess-indent').setup()

require('tokyonight').setup({
    styles = {
      comments = { italic = false },
    },
})
vim.cmd.colorscheme 'tokyonight-night'

require('which-key').setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- require('mini.ai').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
-- require('mini.comment').setup()
require('mini.move').setup() -- move line up/down/left/righ using alt+h/j/k/l
require('mini.trailspace').setup() -- TODO: make it run on save
require('mini.cursorword').setup({delay=0})
require('mini.indentscope').setup()



-- cool statusline
require('lualine').setup()

-- TODO: change this to right side
require("nvim-tree").setup({
    view = {
        width = 35,
    },
    filters = {
        dotfiles = false,
    },
})
vim.keymap.set('n', '<leader>e', function()
require("nvim-tree.api").tree.toggle()
end, {desc = "Toggle NvimTree"})

