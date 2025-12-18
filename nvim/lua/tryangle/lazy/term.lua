return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                direction = "float",
                open_mapping = nil,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                },
            })
        end
    }
}
