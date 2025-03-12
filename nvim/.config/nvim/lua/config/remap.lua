
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- useful for vr
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>")
vim.keymap.set("n", "<leader>sW", function()
        local fzf = require("fzf-lua")
        local cwd = vim.fn.expand("%:h")
        fzf.grep_cword({ cwd = cwd })
end)
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua lsp_references<cr>")
vim.keymap.set("n", "<leader>sc", "<cmd>FzfLua lsp_incoming_calls<cr>")
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>sG", function()
        local fzf = require("fzf-lua")
        local cwd = vim.fn.expand("%:h")
        fzf.live_grep({ cwd = cwd })
end)


vim.cmd.amenu([[PopUp.References <Cmd>lua vim.lsp.buf.references()<CR>]])
vim.cmd.amenu([[PopUp.Incoming\ Calls  <Cmd>lua vim.lsp.buf.incoming_calls()<CR>]])

--vim.keymap.set("n", "<leader><leader>", function()
--    vim.cmd("so")
--end)


