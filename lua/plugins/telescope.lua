return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		-- Files & buffers
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fF",
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
			desc = "Find Files (all)",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Recent Files",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fg",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			desc = "Live Grep (args)",
		},
		{
			"<leader>fw",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Grep Word Under Cursor",
		},
		{
			"<leader>fG",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
			desc = "Grep Prompt",
		},

		-- Git
		{
			"<leader>gc",
			function()
				require("telescope.builtin").git_commits()
			end,
			desc = "Git Commits",
		},
		{
			"<leader>gC",
			function()
				require("telescope.builtin").git_bcommits()
			end,
			desc = "Git Buffer Commits",
		},
		{
			"<leader>gb",
			function()
				require("telescope.builtin").git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gs",
			function()
				require("telescope.builtin").git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				require("telescope.builtin").git_stash()
			end,
			desc = "Git Stash",
		},

		-- LSP (these complement the LSP config's gd/gr/etc with picker UIs)
		{
			"<leader>ls",
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			desc = "Document Symbols",
		},
		{
			"<leader>lS",
			function()
				require("telescope.builtin").lsp_dynamic_workspace_symbols()
			end,
			desc = "Workspace Symbols",
		},
		{
			"<leader>ld",
			function()
				require("telescope.builtin").diagnostics({ bufnr = 0 })
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>lD",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "Workspace Diagnostics",
		},
		{
			"gd",
			function()
				require("telescope.builtin").lsp_definitions()
			end,
			desc = "LSP Definitions",
		},
		{
			"gr",
			function()
				require("telescope.builtin").lsp_references()
			end,
			desc = "LSP References",
		},
		{
			"gI",
			function()
				require("telescope.builtin").lsp_implementations()
			end,
			desc = "LSP Implementations",
		},
		{
			"gy",
			function()
				require("telescope.builtin").lsp_type_definitions()
			end,
			desc = "LSP Type Definitions",
		},

		-- Misc
		{
			"<leader>sh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Help Tags",
		},
		{
			"<leader>sk",
			function()
				require("telescope.builtin").keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sc",
			function()
				require("telescope.builtin").commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sH",
			function()
				require("telescope.builtin").highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>sm",
			function()
				require("telescope.builtin").marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sR",
			function()
				require("telescope.builtin").registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>sr",
			function()
				require("telescope.builtin").resume()
			end,
			desc = "Resume Last Picker",
		},
		{
			"<leader>s/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			desc = "Fuzzy in Buffer",
		},
		{
			"<leader>sn",
			function()
				require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Search Neovim Config",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local lga_actions = require("telescope-live-grep-args.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				entry_prefix = "  ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = { mirror = false },
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_ignore_patterns = {
					"%.git/",
					"node_modules/",
					"%.venv/",
					"__pycache__/",
					"target/",
					"build/",
					"dist/",
					"%.lock",
					"%.png",
					"%.jpg",
					"%.jpeg",
					"%.gif",
					"%.pdf",
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<C-s>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,
						["<esc>"] = actions.close, -- one esc to close, instead of two
					},
					n = {
						["q"] = actions.close,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "--glob=!.git/" },
				},
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
					mappings = {
						i = { ["<C-x>"] = actions.delete_buffer },
						n = { ["dd"] = actions.delete_buffer },
					},
				},
				lsp_references = {
					show_line = false,
					include_declaration = false,
				},
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
						},
					},
				},
			},
		})

		-- Load extensions (after setup)
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "live_grep_args")
	end,
}
