-- install without yarn or npm
return {
	"OXY2DEV/markview.nvim",
	lazy = false,

	config = function()
		vim.keymap.set("n", "<leader>mp", "<CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." })
	end,
}
