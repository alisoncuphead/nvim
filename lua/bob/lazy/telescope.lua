return {
        {
                "nvim-telescope/telescope.nvim",

                tag = "0.1.5",

                dependencies = {
                        "nvim-lua/plenary.nvim",
                },

                config = function()
                        require("telescope").setup({})

                        local builtin = require("telescope.builtin")
                        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
                        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
                        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
                        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
                        vim.keymap.set("n", "<leader>fr",
                                function() builtin.lsp_references({ bufnr = 0 }) end,
                                { desc = "Telescope get references", noremap = true, silent = true })
                        vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols,
                                { desc = "Telescope get document symbols." })
                        vim.keymap.set("n", "<leader>fig",
                                function() builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } }) end,
                                { desc = "Telescope live grep current buffer." })
                        vim.keymap.set("n", "<leader>fx", function() builtin.diagnostics({ bufnr = 0 }) end,
                                { desc = "Telescope get diagnostics" })
                end,
        },
        {
                "nvim-telescope/telescope-ui-select.nvim",
                config = function()
                        require("telescope").setup {
                                extensions = {
                                        ["ui-select"] = {
                                                require("telescope.themes").get_dropdown {
                                                        -- even more opts
                                                }

                                                -- pseudo code / specification for writing custom displays, like the one
                                                -- for "codeactions"
                                                -- specific_opts = {
                                                --   [kind] = {
                                                --     make_indexed = function(items) -> indexed_items, width,
                                                --     make_displayer = function(widths) -> displayer
                                                --     make_display = function(displayer) -> function(e)
                                                --     make_ordinal = function(e) -> string
                                                --   },
                                                --   -- for example to disable the custom builtin "codeactions" display
                                                --      do the following
                                                --   codeactions = false,
                                                -- }
                                        }
                                }
                        }
                        -- To get ui-select loaded and working with telescope, you need to call
                        -- load_extension, somewhere after setup function:
                        require("telescope").load_extension("ui-select")
                end
        },
}
