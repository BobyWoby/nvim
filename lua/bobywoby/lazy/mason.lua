require("mason").setup()
require("nvim-dap-virtual-text").setup({
    event="VeryLazy",
  ensure_installed = {
    "codelldb"
  },
  automatic_installation = true
})
return {
    "mason-org/mason.nvim",
    'mason-org/mason-lspconfig.nvim',
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    opts={},
}
