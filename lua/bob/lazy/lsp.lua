return {
        {
                "neovim/nvim-lspconfig",
                dependencies = {
                        "williamboman/mason.nvim",
                        "williamboman/mason-lspconfig.nvim",
                        "neovim/nvim-lspconfig",
                        "hrsh7th/nvim-cmp",
                        "hrsh7th/cmp-nvim-lsp",
                },
                config = function()
                        require("cmp").setup({
                                source = {
                                        { name = "nvim_lsp" },
                                },
                        })

                        require("mason").setup()
                        require("mason-lspconfig").setup({
                                ensure_installed = {
                                        "lua_ls",
                                        "pyright",
                                },
                        })

                        local lspconfig_defaults = require("lspconfig").util.default_config
                        local cmp_lsp = require("cmp_nvim_lsp")
                        local capabilities =
                            vim.tbl_deep_extend("force", {}, lspconfig_defaults.capabilities,
                                    cmp_lsp.default_capabilities())

                        require("lspconfig").lua_ls.setup({
                                capabilities = capabilities,
                        })
                        require("lspconfig").pyright.setup({
                                capabilities = capabilities,
                        })
                        local cmp = require('cmp')

                        cmp.setup({
                                sources = {
                                        { name = "nvim_lsp" },
                                },
                                snippet = {
                                        expand = function(args)
                                                -- You need Neovim v0.10 to use vim.snippet
                                                vim.snippet.expand(args.body)
                                        end,
                                },
                                mapping = cmp.mapping.preset.insert({}),
                        })
                        vim.keymap.set("n", "<leader>fv", function()
                                vim.lsp.buf.format()
                        end)
                end,
        },
}
