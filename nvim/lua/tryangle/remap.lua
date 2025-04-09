vim.g.mapleader = " "

-- open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- select whole file
vim.keymap.set('n', '<leader>a', 'gg0VG$')

-- move selected text up and down and ident correctly
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- jump to line start or end
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "L", "$")

-- remove the next newline
-- vim.keymap.set("n", "J", "mzJ`z")

-- jump half the editor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- better jump next on search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- move text by one ident
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")


vim.keymap.set("n", "<C-A-Up>", "<cmd>normal! yyP<CR>")

-- create new scope and center cursor in it
vim.keymap.set("n", "<leader>{", "A{<CR>}<Esc>O")

-- copy and pasting changes
vim.keymap.set("x", "p", "\"_dP")        -- by default visual does not copy replaced text
vim.keymap.set("x", "<leader>p", "P")    -- paste and copy replaced text
vim.keymap.set("v", "<leader>y", "\"+y") -- copy selected text and jump to start of selection
vim.keymap.set("n", "<leader>Y", "\"+Y") -- copy whole line

-- wtf is ex mode
vim.keymap.set("n", "Q", "<nop>")

-- search current word in current scope and select it for replace
-- vim.keymap.set("n", "<leader>s", [[gd[{V%:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true })
-- search current word in current file and select it for replace
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>nt', ':Neotree toggle<CR>', { silent = true, noremap = true })

-- toggle terminal
vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { silent = true, noremap = true })
-- escape will escape the terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- jump windows fast
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- integration with tmux
vim.keymap.set('n', '<leader>tmd', function() vim.fn.system("tmux detach") end, { silent = true })
vim.keymap.set('n', '<leader>tms', function() vim.fn.system("tmux display-popup -E \"tms switch\"") end)
