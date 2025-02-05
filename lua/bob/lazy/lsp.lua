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
                                        {name = 'nvim_lsp'}
                                }
                        })

                        require("mason").setup(                        )
                        require("mason-lspconfig").setup({
                                ensure_installed = {
                                        "lua_ls",
                                        "pyright",
                                }
                        })


                        local capabilities = require("cmp_nvim_lsp").default_capabilities()

                        require("lspconfig").lua_ls.setup({
                                on_attach = lsp_attach,
                                capabilities = capabilities,
                        })
                        require("lspconfig").pyright.setup{}
                end,

        }
}
