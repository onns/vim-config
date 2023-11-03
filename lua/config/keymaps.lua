-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

function GoToPathAndLine(input)
    if input == '' then
        return
    end
    local parts = vim.split(input, ':')
    local file = parts[1]
    local line = 1
    if #parts > 1 then
        line = parts[2]
    end
    -- 如果有工作路径，选第一个，否则选当前路径
    local pwd = vim.fn.getcwd()
    if vim.g.WorkspaceFolders and #vim.g.WorkspaceFolders > 0 then
        pwd = vim.g.WorkspaceFolders[1]
    end
    vim.cmd('edit +' .. line .. ' ' .. pwd .. '/' .. file)
end

vim.api.nvim_set_keymap('n', 'gto', ':lua GoToPathAndLine(vim.fn.input("Enter path and line: "))<CR>', { noremap = true })

function ExportExpandToClipboard()
    local rf = vim.fn.expand('%:p') .. ':' .. vim.fn.line('.')
    local expanded = string.sub(rf, string.len(vim.g.WorkspaceFolders[1] .. '/') + 1)
    vim.fn.setreg('+', expanded)
    print('Expanded path copied to clipboard: ' .. expanded)
end

vim.api.nvim_set_keymap('n', 'gcr', ':lua ExportExpandToClipboard()<CR>', { noremap = true })