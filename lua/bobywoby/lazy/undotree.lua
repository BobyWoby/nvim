return{
    'mbbill/undotree',
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
}
