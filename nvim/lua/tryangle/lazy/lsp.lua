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
        "MysticalDevil/inlay-hints.nvim",
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp = require('cmp')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("fidget").setup({})
        require("mason").setup()

        -- 1. Extract on_attach (reusable for both Mason and System servers)
        local on_attach = function(client, bufnr)
            require("inlay-hints").on_attach(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>fmt', vim.lsp.buf.format, opts)
        end

        require("mason-lspconfig").setup({
            ensure_installed = {
                -- REMOVE "rust_analyzer" here so Mason doesn't manage it
            },
            handlers = {
                function(server_name)
                    -- Note: You can eventually update this to use vim.lsp.config too,
                    -- but for now, keeping the old handler for Mason servers is safer
                    -- until mason-lspconfig fully defaults to the new API.
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                    }
                end,
            }
        })

        -- 2. Manually setup system rust_analyzer using the NEW 0.11 API
        -- vim.lsp.config registers/overrides the config
        vim.lsp.config('rust_analyzer', {
            capabilities = capabilities,
            on_attach = on_attach,
            -- cmd = { 'rust-analyzer' }, -- Implicitly looks in $PATH, perfect for system binary
        })
        
        -- vim.lsp.enable activates it (sets up filetype triggers)
        vim.lsp.enable('rust_analyzer')

        -- ... rest of your cmp setup ...
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<S-Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.close()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<S-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<S-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<S-CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
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
