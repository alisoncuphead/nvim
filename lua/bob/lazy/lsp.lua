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
                        vim.api.nvim_create_autocmd("LspAttach", {
                                desc = "LSP actions",
                                callback = function(event)
                                        local opts = { buffer = event.buf }

                                        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                                        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                                        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                                        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                                        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                                        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                                        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                                        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                                        vim.keymap.set({ "n", "x" }, "<leader>fv",
                                                "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                                        vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                                end,
                        })
                        require("lspconfig").lua_ls.setup({
                                capabilities = capabilities,
                        })
                        require("lspconfig").pyright.setup({
                                capabilities = capabilities,
                        })
                        require("lspconfig").bashls.setup({
                                capabilities = capabilities
                        })
                        require("lspconfig").ts_ls.setup({
                                capabilities = capabilities,
                               init_options = {
                                preferences = {
                                        disableSuggestions = true,
                                        }}
                        })
                        require("lspconfig").gopls.setup({
                                capabilities = capabilities,
                        })
--                        require("lspconfig").biome.setup({
--                                capabilities = capabilities,
--                                on_attach = function(client, bufnr)
--                                        print('biome attached')
--                                end
--                        })
                        local cmp = require("cmp")

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
                                mapping = cmp.mapping.preset.insert({
                                        ["<C-Space>"] = cmp.mapping.complete(),
                                        ["<tab>"] = cmp.mapping.confirm({ select = true }),
                                }),
                        })
                        vim.keymap.set("n", "<cmd>fv", function()
                                vim.lsp.buf.format()
                        end)
                end,
        },
}
