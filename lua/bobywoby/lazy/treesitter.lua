return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        max_lines = 4,
        multiline_threshold = 2,
      },
    },
  },
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')

    -- State tracking for async parser loading
    local parsers_loaded = {}
    local parsers_pending = {}
    local parsers_failed = {}

    local ns = vim.api.nvim_create_namespace('treesitter.async')

    -- Helper to start highlighting and indentation
    local function start(buf, lang)
      local ok = pcall(vim.treesitter.start, buf, lang)
      if ok then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
      return ok
    end

    -- Install core parsers after lazy.nvim finishes loading all plugins
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyDone',
      once = true,
      callback = function()
        ts.install({
          'bash',
          'comment',
          'css',
          'diff',
          'fish',
          'git_config',
          'git_rebase',
          'gitcommit',
          'gitignore',
          'html',
          'javascript',
          'json',
          'latex',
          'lua',
          'luadoc',
          'make',
          'markdown',
          'markdown_inline',
          'norg',
          'python',
          'query',
          'regex',
          'scss',
          'svelte',
          'toml',
          'tsx',
          'typescript',
          'typst',
          'vim',
          'vimdoc',
          'vue',
          'xml',
        }, {
          max_jobs = 8,
        })
      end,
    })

    -- Decoration provider for async parser loading
    vim.api.nvim_set_decoration_provider(ns, {
      on_start = vim.schedule_wrap(function()
        if #parsers_pending == 0 then
          return false
        end
        for _, data in ipairs(parsers_pending) do
          if vim.api.nvim_buf_is_valid(data.buf) then
            if start(data.buf, data.lang) then
              parsers_loaded[data.lang] = true
            else
              parsers_failed[data.lang] = true
            end
          end
        end
        parsers_pending = {}
      end),
    })

    local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

    local ignore_filetypes = {
      'checkhealth',
      'lazy',
      'mason',
      'snacks_dashboard',
      'snacks_notif',
      'snacks_win',
    }

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      desc = 'Enable treesitter highlighting and indentation (non-blocking)',
      callback = function(event)
        if vim.tbl_contains(ignore_filetypes, event.match) then
          return
        end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf

        if parsers_failed[lang] then
          return
        end

        if parsers_loaded[lang] then
          -- Parser already loaded, start immediately (fast path)
          start(buf, lang)
        else
          -- Queue for async loading
          table.insert(parsers_pending, { buf = buf, lang = lang })
        end

        -- Auto-install missing parsers (async, no-op if already installed)
        ts.install({ lang })
      end,
    })
  end,
}
-- return {{
--
-- 		"nvim-treesitter/nvim-treesitter",
-- 		config = function()
-- 			require("nvim-treesitter.configs").setup({
-- 				-- A list of parser names, or "all"
-- 				ensure_installed = {
-- 					"vimdoc",
-- 					"javascript",
-- 					"typescript",
-- 					"c",
-- 					"lua",
-- 					"rust",
-- 					"jsdoc",
-- 					"bash",
-- 					"go",
-- 				},
--
-- 				-- Install parsers synchronously (only applied to `ensure_installed`)
-- 				sync_install = false,
--
-- 				-- Automatically install missing parsers when entering buffer
-- 				-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
-- 				auto_install = true,
--
-- 				indent = {
-- 					enable = true,
-- 				},
--
-- 				highlight = {
-- 					-- `false` will disable the whole extension
-- 					enable = true,
-- 					disable = function(lang, buf)
-- 						if lang == "html" then
-- 							print("disabled")
-- 							return true
-- 						end
--
-- 						local max_filesize = 100 * 1024 -- 100 KB
-- 						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
-- 						if ok and stats and stats.size > max_filesize then
-- 							vim.notify(
-- 								"File larger than 100KB treesitter disabled for performance",
-- 								vim.log.levels.WARN,
-- 								{ title = "Treesitter" }
-- 							)
-- 							return true
-- 						end
-- 					end,
--
-- 					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- 					-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
-- 					-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- 					-- Instead of true it can also be a list of languages
-- 					additional_vim_regex_highlighting = { "markdown" },
-- 				},
-- 			})
--
-- 			local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- 			treesitter_parser_config.templ = {
-- 				install_info = {
-- 					url = "https://github.com/vrischmann/tree-sitter-templ.git",
-- 					files = { "src/parser.c", "src/scanner.c" },
-- 					branch = "master",
-- 				},
-- 			}
--
-- 			vim.treesitter.language.register("templ", "templ")
-- 		end,
-- 	},
--
-- 	{
-- 		"nvim-treesitter/nvim-treesitter-context",
-- 		after = "nvim-treesitter",
-- 		config = function()
-- 			require("treesitter-context").setup({
-- 				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
-- 				multiwindow = false, -- Enable multiwindow support.
-- 				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
-- 				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
-- 				line_numbers = true,
-- 				multiline_threshold = 20, -- Maximum number of lines to show for a single context
-- 				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
-- 				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
-- 				-- Separator between context and content. Should be a single character string, like '-'.
-- 				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
-- 				separator = nil,
-- 				zindex = 20, -- The Z-index of the context window
-- 				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- 			})
-- 		end,
-- 	}
-- }
--
