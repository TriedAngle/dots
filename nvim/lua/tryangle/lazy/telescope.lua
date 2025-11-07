return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup{ 
          defaults = { 
            file_ignore_patterns = { 
                "node_modules",
                "target"
            },
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    
            -- Command to use for finding files.
            -- This setup checks if 'fd' is executable and uses it if available.
            -- The '--hidden' flag includes dotfiles.
            -- The '--no-ignore' flag would disable respecting .gitignore, but we want it enabled.
            -- The '--follow' flag follows symbolic links.
            find_command = {
              'fd',
              '--type', 'f',
              '--hidden',
              '--follow',
              '--exclude', '.git' -- We can still add specific excludes if needed
            },
          }
        }

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
