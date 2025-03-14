

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
    config = function()
        local harpoon = require("harpoon")
        local function get_tag_file(tag)
            local end_pos = string.find(tag, ":")
            local buf = string.sub(tag, 1, end_pos-1)
            return buf
        end
        local function to_exact_name(value)
            return "^" .. value .. "$"
        end

        harpoon:setup({
            ["bookmarks"] = {
                create_list_item = function(config, _)
                    local Path = require("plenary.path")
                    local function normalize_path(buf_name, root)
                        return Path:new(buf_name):make_relative(root)
                    end
                    local txt = normalize_path(
                        vim.api.nvim_buf_get_name(
                            vim.api.nvim_get_current_buf()
                        ),
                        config.get_root_dir()
                    )

                    local idx = vim.fn.line(".")
                    local bm = vim.api.nvim_buf_get_lines(0, idx-1, idx, false)[1]
                    if bm == nil then
                        return nil
                    end

                    
                    local bufnr = vim.fn.bufnr(txt, false)

                    local pos = { 1, 0 }
                    if bufnr ~= -1 then
                        pos = vim.api.nvim_win_get_cursor(0)
                    end

                    return {
                        value = txt .. ":"..pos[1]..": "..bm,
                        context = {
                            row = pos[1],
                            col = pos[2],
                        },
                    }
                end,

                select = function(list_item, list, options)
                    local Logger = require("harpoon.logger")
                    local Extensions = require("harpoon.extensions")
                    Logger:log(
                        "config_default#select",
                        list_item,
                        list.name,
                        options
                    )
                    if list_item == nil then
                        return
                    end

                    options = options or {}

                    local bufnr = vim.fn.bufnr(to_exact_name(get_tag_file(list_item.value)))
                    local set_position = true
                    if bufnr == -1 then -- must create a buffer!
                        set_position = true
                        -- bufnr = vim.fn.bufnr(list_item.value, true)
                        bufnr = vim.fn.bufadd(get_tag_file(list_item.value))
                    end
                    if not vim.api.nvim_buf_is_loaded(bufnr) then
                        vim.fn.bufload(bufnr)
                        vim.api.nvim_set_option_value("buflisted", true, {
                            buf = bufnr,
                        })
                    end

                    if options.vsplit then
                        vim.cmd("vsplit")
                    elseif options.split then
                        vim.cmd("split")
                    elseif options.tabedit then
                        vim.cmd("tabedit")
                    end

                    vim.api.nvim_set_current_buf(bufnr)

                    if set_position then
                        local lines = vim.api.nvim_buf_line_count(bufnr)

                        local edited = false
                        if list_item.context.row > lines then
                            list_item.context.row = lines
                            edited = true
                        end

                        local row = list_item.context.row
                        local row_text =
                            vim.api.nvim_buf_get_lines(0, row - 1, row, false)
                        local col = #row_text[1]

                        if list_item.context.col > col then
                            list_item.context.col = col
                            edited = true
                        end

                        vim.api.nvim_win_set_cursor(0, {
                            list_item.context.row or 1,
                            list_item.context.col or 0,
                        })

                        if edited then
                            Extensions.extensions:emit(
                                Extensions.event_names.POSITION_UPDATED,
                                {
                                    list_item = list_item,
                                }
                            )
                        end
                    end

                    Extensions.extensions:emit(Extensions.event_names.NAVIGATE, {
                        buffer = bufnr,
                    })

                end,

                -- display = function(list_item)
                --
                --     return get_tag_file(list_item.value)
                -- end,
            }
        })

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, get_tag_file(item.value)..":"..item.context.row)
            end
        
            require("telescope.pickers").new({}, {
                prompt_title = "bookmarks",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end
        
        -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list("bookmarks")) end,
        --     { desc = "Open harpoon window" })
        --

        vim.keymap.set("n", "<leader>a", function() harpoon:list("bookmarks"):add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list("bookmarks"), {title="bookmarks"}) end)
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

    end
}
