return{
    "danymat/neogen",
    config = function()
        require('neogen').setup {}
        vim.keymap.set("n",  "<leader>nf", "<cmd>Neogen<CR>");
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
}
