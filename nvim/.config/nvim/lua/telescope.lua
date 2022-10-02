
-- keybindings
vim.keymap.set("n", "<C-p>", ":Telescope<CR>", {noremap = true});
vim.keymap.set("n", "<leader>ps", function() 
        require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")}) 
    end, {noremap = true})
vim.keymap.set("n", "<leader>pw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>")}
end, {noremap = true})
vim.keymap.set("n", "<leader>pf", function()
    require('telescope.builtin').find_files()
end, {noremap = true})
