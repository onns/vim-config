-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.go_fmt_command = 'goimports'
vim.g.go_autodetect_gopath = 1
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_generate_tags = 1

vim.g.go_gopls_enabled = 1
vim.g.go_gopls_options = { '-remote=unix;/tmp/gopls-daemon-socket' }
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = 'gopls'
vim.g.go_referrers_mode = 'gopls'

vim.api.nvim_set_keymap('n', 'gd', "<Plug>(coc-definition)", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', "<Plug>(coc-references)", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gm', "<Plug>(coc-implementation)", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-g>', ':GoDeclsDir<CR>', { silent = true })
vim.api.nvim_set_keymap('i', '<C-g> <esc>', ':<C-u>GoDeclsDir<CR>', { silent = true })

-- tagbar 打开后自动聚焦
vim.g.tagbar_autofocus = 1


vim.opt.wrap = true