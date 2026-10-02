-- highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})


-- remove extra whitespaces
-- vim.api.nvim_create_autocmd('TrimTrailingSpaces', {
--     desc = 'Remove trailing whitespaces on save',
--     group = vim.api.nvim_create_augroup('remove-trailing-whitespaces', { clear = true }),
--     callaback = function()
--
--     end,
-- })
