return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Diagnostics UI
		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 2 },
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
		})

		-- Pretty signs in the gutter
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Keymaps and buffer-local options applied on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
			callback = function(event)
				local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				-- map("gd", vim.lsp.buf.definition, "Goto Definition")
				-- map("gr", vim.lsp.buf.references, "Goto References")
				-- map("gI", vim.lsp.buf.implementation, "Goto Implementation")
				-- map("gD", vim.lsp.buf.declaration, "Goto Declaration")
				map("gy", vim.lsp.buf.type_definition, "Type Definition")
				map("K", vim.lsp.buf.hover, "Hover")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
				map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
				map("]d", vim.diagnostic.goto_next, "Next Diagnostic")

				-- Highlight references under cursor
				if client and client.server_capabilities.documentHighlightProvider then
					local hl_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = hl_group,
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = hl_group,
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Inlay hints (Neovim 0.10+)
				if client and client.supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					map("<leader>uh", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
					end, "Toggle Inlay Hints")
				end
			end,
		})

		-- Capabilities (nvim-cmp integration; harmless if you don't use cmp)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
		end

		-- Per-server overrides. Add servers here; empty table = defaults.
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } },
						hint = { enable = true },
					},
				},
			},
			pyright = {},
			ts_ls = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
					},
				},
			},
			gopls = {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							parameterNames = true,
						},
					},
				},
			},
			bashls = {},
			jsonls = {},
			yamlls = {},
			html = {},
			cssls = {},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			},
		}

		require("mason").setup({
			ui = { border = "rounded" },
		})

		require("mason-tool-installer").setup({
			ensure_installed = vim.list_extend(vim.tbl_keys(servers), {
				"stylua",
				"prettierd",
				"shfmt",
				"clang-format",
				"goimports",
				"ruff",
			}),
		})

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
