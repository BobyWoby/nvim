vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
-- Telescope
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

use "kyazdani42/nvim-web-devicons"
-- STATUS LINES
-- Vim-Airline
-- use 'vim-airline/vim-airline'

-- Incline
-- use "b0o/incline.nvim"

-- Spaceline
-- Plug 'glepnir/spaceline.vim'


-- Galxaxyline
use({
  "NTBBloodbath/galaxyline.nvim",
  -- your statusline
  config = function()
    require("galaxyline.themes.eviline")
  end,
  -- some optional icons
  requires = { "kyazdani42/nvim-web-devicons", opt = true }
})

-- COLORSCHEMES
-- Rose-Pine
-- use {
--     "dylanaraps/wal.vim"
-- }
--   use({ 'rose-pine/neovim', as = 'rose-pine',
--
--   config = function()
-- 	  vim.cmd('colorscheme rose-pine')
--   end
--   })

-- kanagawa 
use "rebelot/kanagawa.nvim"

-- Nord
  --use({'shaunsingh/nord.nvim', 
  --as = 'nord-nvim',
  --config = function()
	  --vim.cmd[[colorscheme nord]]
	  --vim.g.nord_contrast = true
	  --end})

use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
use( 'nvim-treesitter/playground')

-- Undo Tree
use 'mbbill/undotree'
use 'tpope/vim-fugitive'

-- LSP Zero
use {
	'VonHeikemen/lsp-zero.nvim',
	requires = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	}
}

-- Mason
use { "mason-org/mason.nvim"
}
use { 'mason-org/mason-lspconfig.nvim' }
use {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
}

-- Comment
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup(
            {
                toggler = {
                    ---Line-comment toggle keymap
                    line = '<C-/>',
                    ---Block-comment toggle keymap
                    block = '<C-?>',
                },
            }
        )
    end
}


-- Vsnip
use { 'hrsh7th/vim-vsnip'}
use { 'hrsh7th/vim-vsnip-integ'}
use { 'hrsh7th/cmp-vsnip'}

-- LuaSnip
use({
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	run = "make install_jsregexp"
})


-- -- LSP-Signature
-- use {
--   "ray-x/lsp_signature.nvim",
-- }

use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
}


use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
use  'theHamsta/nvim-dap-virtual-text'

use({
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
})
-- install without yarn or npm
use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})

use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

use{'fatih/vim-go'}

use("catgoose/nvim-colorizer.lua")

use("Civitasv/cmake-tools.nvim")
use {
    "folke/todo-comments.nvim",
    requires = {"nvim-lua/plenary.nvim"}
}

use {
    "danymat/neogen",
    config = function()
        require('neogen').setup {}
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
}

end)
