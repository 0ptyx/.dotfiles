--
--
--
--

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
                require('luasnip').lsp_expand(args.body)

        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({select = true}),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-spac>'] = cmp.mapping.complete()
    }),
    sources = {
        { name = "nvim_lsp"},
        { name = "luasnip"},
        { name = "buffer"}
    },
})

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, bufopts)

end 

require('lspconfig').rust_analyzer.setup{
    on_attach = on_attach
}

require('lspconfig').ccls.setup{
    on_attach = on_attach
}

require('lspconfig').pylsp.setup{
    on_attach = on_attach
}

require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
            Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
                globals = { "vim" }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            },
            telemetry = {
                enable = false,
            }
        }
    }
}
