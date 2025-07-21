function ColorMyPencils(color)
    
    vim.cmd  "colorscheme kanagawa-wave"
    -- vim.cmd "colorscheme rose-pine"
    -- vim.cmd [[
    -- highlight Normal guibg=none
    -- highlight NonText guibg=none
    -- highlight Normal ctermbg=none
    -- highlight NonText ctermbg=none
    -- ]]
    -- require('rose-pine').setup({
    --     --- @usage 'auto'|'main'|'moon'|'dawn'
    --     variant = 'auto',
    --     --- @usage 'main'|'moon'|'dawn'
    --     dark_variant = 'main',
    --     bold_vert_split = false,
    --     dim_nc_background = false,
    --     disable_background = true,
    --     disable_float_background = true,
    --     disable_italics = true,
    --
    --     styles={
    --         bold=false}
    --     })
    --     vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    --     vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
    end

return  {
    'rebelot/kanagawa.nvim',
    config=function()
        ColorMyPencils()
    end
}
