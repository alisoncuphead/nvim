return {
        'kevinhwang91/nvim-ufo',
        dependencies = {
                'kevinhwang91/promise-async',
                'nvim-treesitter/nvim-treesitter'
        },
        config = function()
                vim.o.foldcolumn = '1' -- Show a fold column
                vim.o.foldlevel = 99 -- Keep everything unfolded by default
                vim.o.foldenable = true -- Enable folding

                require('ufo').setup({
                        provider_selector = function(bufnr, filetype, buftype)
                                return { 'lsp',  'indent' }
                        end,
                        -- Optional: Configure foldtext for better display of folded lines
                        fold_virt_text_handler = function(virt_text)
                                local new_virt_text = {}
                                for i, chunk in ipairs(virt_text) do
                                        if chunk[1]:match("^[ \t]*%S+") then -- Match non-whitespace character
                                                new_virt_text[i] = chunk
                                        end
                                end
                                return new_virt_text
                        end,
                })
                vim.keymap.set('n','zR',require('ufo').openAllFolds)
                vim.keymap.set('n','zM',require('ufo').closeAllFolds)
                vim.keymap.set('n','zr',require('ufo').openFoldsExceptKinds)
                vim.keymap.set('n','zm',require('ufo').closeFoldsWith)
                vim.keymap.set('n','K', function()
                        local winid = require('ufo').peekFoldedLinesUnderCursor()
                        if not winid then 
                                vim.lsp.buf.hover()
                        end
                end
                )
        end
}
