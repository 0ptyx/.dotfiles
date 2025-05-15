return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                styles = {
                    italic = false,
                },
            })
        end
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = function()
    end, opts = ...},

    { "Shatur/neovim-ayu", priority = 1000, config = function()
        require('ayu').setup({
            overrides = {
                LineNr = { fg = "#465063" },
            },
        })
        vim.cmd([[colorscheme ayu-dark]])
    end, opts = ... }


}
