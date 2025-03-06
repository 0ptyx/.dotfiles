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
        vim.cmd([[colorscheme gruvbox]])
    end, opts = ...}


}
