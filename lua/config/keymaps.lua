vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window commands" })
vim.keymap.set("n", "<leader>W", "<C-w>", { desc = "Window commands" })

vim.keymap.set("n", "<C-d>", '<C-d>zz')
vim.keymap.set("n", "<C-u>", '<C-u>zz')
vim.keymap.set("n", "gd", 'gdzz')
vim.keymap.set("n", "n", 'nzz')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", 'Ypk')
vim.keymap.set("v", "<C-k>", 'yp')

vim.keymap.set("n", "<leader>d", '"_d')

vim.keymap.set("v", "<F6>", vim.lsp.buf.rename) -- TODO: Maybe get rid of this

vim.keymap.set('i', "<C-c>", "<Esc>");

