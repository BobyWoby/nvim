return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
		{
			"<leader>uf",
			function()
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				vim.notify("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"), vim.log.levels.INFO)
			end,
			desc = "Toggle autoformat (global)",
		},
		{
			"<leader>ub",
			function()
				vim.b.disable_autoformat = not vim.b.disable_autoformat
				vim.notify(
					"Autoformat " .. (vim.b.disable_autoformat and "disabled" or "enabled") .. " for buffer",
					vim.log.levels.INFO
				)
			end,
			desc = "Toggle autoformat (buffer)",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			jsonc = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			go = { "goimports", "gofmt" },
			rust = { "rustfmt", lsp_format = "fallback" },
			cpp = { "clang-format" },
			c = { "clang-format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			-- Run on every filetype
			["_"] = { "trim_whitespace", "trim_newlines" },
		},

		-- Run before save
		format_on_save = function(bufnr)
			-- Respect the toggles
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			-- Don't autoformat huge files
			local max_filesize = 1024 * 1024 -- 1 MB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
			if ok and stats and stats.size > max_filesize then
				return
			end
			return {
				timeout_ms = 1000,
				lsp_format = "fallback",
			}
		end,

		-- Tweaks for individual formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" }, -- 2-space indent, indent switch cases
			},
			["clang-format"] = {
				prepend_args = { "--style=file", "--fallback-style=LLVM" },
			},
		},

		-- Show LSP-format errors instead of swallowing them
		notify_on_error = true,
	},
	init = function()
		vim.g.disable_autoformat = true
		-- Used by some users' :wq habits; lets gq use conform
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
