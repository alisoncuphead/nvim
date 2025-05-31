vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", "<cmd>:update<cr>")
-- hello w

vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
                vim.highlight.on_yank()
        end,
})

local saveAndQuit = function()
        vim.cmd("bp | sp | bn | bd")
end

vim.keymap.set("n", "<leader>o", "mao<esc>0<S-d>`a<cmd>delmarks a<cr>", { desc = "Add new line below" })
vim.keymap.set("n", "<leader>q", saveAndQuit, { desc = "save and quit buffer" })
vim.keymap.set("n", '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })


