return {
    {
      'rmagatti/auto-session',
      config = function()
        require('auto-session').setup({
          log_level = 'error',
          root_dir = vim.fn.stdpath('data') .. '/sessions/',
          auto_save = true,
          auto_restore = true,
          suppress_dirs = { '~/', '/tmp/' },
          session_lens = {
            load_on_setup = true,
          }
        })
      end,
    },
  }