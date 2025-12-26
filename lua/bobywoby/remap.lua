vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-d>", '<C-d>zz')
vim.keymap.set("n", "<C-u>", '<C-u>zz')
vim.keymap.set("n", "gd", 'gdzz')
vim.keymap.set("n", "n", 'nzz')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", 'Ypk')
vim.keymap.set("v", "<C-k>", 'yp')

-- Makes it so that my  delete doesn't save   into my  paste registe
vim.keymap.set("n", "<leader>d", '"_d')

-- Insert Matching Braces
vim.keymap.set("i", '(', '()<Esc>ha')
vim.keymap.set("i", '{', '{}<Esc>ha')
vim.keymap.set("i", '[', '[]<Esc>ha')
vim.keymap.set("i", "'", "''<Esc>ha")
vim.keymap.set("i", '<leader><', '<><Esc>ha')
vim.keymap.set("i", '"', '""<Esc>ha')

vim.keymap.set("v", "<F6>", vim.lsp.buf.rename)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<C-E>", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<C-q>", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set({ 'n' }, '<C-s>', function()
    require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set({ 'v' }, '<C-s>', function()
    vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set('i', "<C-c>", "<Esc>");


vim.keymap.set("n", "<leader>nf", "<cmd>Neogen<CR>");
--
-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", opts)
--

-- vim.keymap.set({ 'n' }, '<C-k>', function()       require('lsp_signature').toggle_float_win()
--     end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set({ 'n' }, '<Leader>k', function()
    vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set('n', 'ga', function()
    vim.lsp.buf.code_action()
end)

-- Makes it so  leader p pastes  over line without copying it
vim.keymap.set("x", "p", [["_dP]])

-- Debugging keymaps
vim.keymap.set("n", "<C-b>", function()
    require "dap".toggle_breakpoint()
end)
vim.keymap.set('n', '<F5>', "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set('n', '<F6>', "<cmd>lua vim.lsp.buf.format()<CR>")

vim.keymap.set('n', "tt", "<cmd>TodoQuickFix<cr>")
