return {
	"nvim-treesitter/nvim-treesitter",
	-- `master` only supports Neovim 0.10/0.11.  The actively maintained
	-- `main` branch supports the Tree-sitter API shipped by Neovim 0.12.
	branch = "main",
	build = ":TSUpdate",
}
