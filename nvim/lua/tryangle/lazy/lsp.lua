return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = function(_, bufnr)
                            local opts = { noremap = true, silent = true, buffer = bufnr }

                            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts) -- Jump to definition
                            vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts) -- Show hover information
                            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts) -- Go to implementation
                            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts) -- Show diagnostics
                            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- Go to previous diagnostic
                            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- Go to next diagnostic
                            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts) -- S
                        end,
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<S-CR>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
