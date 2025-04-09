return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "frappe", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "frappe",
            },
            transparent_background = false, -- disables setting the background color
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false, -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            no_underline = false, -- Force no underline
            styles = {
                comments = {},
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            custom_highlights = {},
            integrations = {
                lsp_trouble = false,
                nvimtree = false,
                treesitter = true, -- For nvim-treesitter
                lspsaga = false,
                -- Here you can add more integrations if needed
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end
}
