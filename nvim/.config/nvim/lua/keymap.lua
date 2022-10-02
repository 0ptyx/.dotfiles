-- *DJ Kahlid* Keyssss!
--
-- navagation
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { noremap = true })

-- use Ctrl-s to navigate splits
vim.keymap.set("n", "<C-s>h", ":wincmd h<CR>", { noremap = true, silent = true})
vim.keymap.set("n", "<C-s>l", ":wincmd l<CR>", { noremap = true, silent = true})

-- File manipulation
--
vim.keymap.set("n", "<leader>w", ":w<CR>" ,{})
vim.keymap.set("i", "<C-c>", "<esc>", {noremap = true})
vim.keymap.set("n", "<leader>u", ":UndotreeShow<CR>", {noremap = true })


-- Special
vim.keymap.set("n", "<C-f>", "<cmd>!tmux neww tmux-sessionizer<CR>", { noremap = true, silent = true})
vim.keymap.set("n", "Q", "<nop>", {noremap = true, silent = true })
-- vim.keymap.set("x", "<leader>p", "\"_dP", {noremap = true})

