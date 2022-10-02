return require('packer').startup(function()
	use('wbthomason/packer.nvim')

    -- Language things
    use('neovim/nvim-lspconfig')
    use("nvim-lua/lsp_extensions.nvim")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use{'nvim-treesitter/nvim-treesitter', run = function() require('nvim-tresitter.install').update({with_sync = true }) end,}
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use('mfussenegger/nvim-dap')
    use{ "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use('theHamsta/nvim-dap-virtual-text')


    -- nvim functionality things
    use('nvim-lua/plenary.nvim')
    use('nvim-telescope/telescope.nvim')
    use('mbbill/undotree')

    -- Colors
    use("EdenEast/nightfox.nvim")
    use('jacoborus/tender.vim')
    use('folke/tokyonight.nvim')

    -- Other 
end)
