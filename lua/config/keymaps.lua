-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

function SaveHttpResp()
    -- 获取当前时间并格式化为时间戳
    local timestamp = os.date("%Y%m%d%H%M%S")

    -- 获取当前文件的目录路径
    local current_path = vim.fn.expand('%:p:h')

    -- 定位到 rest.nvim 的响应缓冲区
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].filetype == 'httpResult' then
            -- 设置保存文件的完整路径，包含时间戳
            local filename = current_path .. "/log/response_" .. timestamp .. ".txt"
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd('w ' .. filename)
            end)
            print("Response saved to " .. filename)
            break
        end
    end
end

vim.api.nvim_set_keymap('n', '<leader>rr',
    ":lua require('rest-nvim').run()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>rs',
    ":lua SaveHttpResp()<CR>",
    { noremap = true, silent = true })


function GetGoplsRootDir()
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
        if client.name == "gopls" and client.config.root_dir then
            return client.config.root_dir
        end
    end
    return nil -- 返回 nil 如果没有找到 gopls 或者 gopls 没有根目录
end

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
    -- if vim.g.WorkspaceFolders and #vim.g.WorkspaceFolders > 0 then
    --     pwd = vim.g.WorkspaceFolders[1]
    -- end
    local goplsRootDir = GetGoplsRootDir()
    if goplsRootDir then
        pwd = goplsRootDir
    end
    vim.cmd('edit +' .. line .. ' ' .. pwd .. '/' .. file)
end

vim.api.nvim_set_keymap('n', 'gto', ':lua GoToPathAndLine(vim.fn.input("Enter path and line: "))<CR>', { noremap = true })

function ExportExpandToClipboard()
    local pwd = vim.fn.getcwd()
    local goplsRootDir = GetGoplsRootDir()
    if goplsRootDir then
        pwd = goplsRootDir
    end
    local rf = vim.fn.expand('%:p') .. ':' .. vim.fn.line('.')
    local expanded = string.sub(rf, string.len(pwd .. '/') + 1)
    vim.fn.setreg('+', expanded)
    print('Expanded path copied to clipboard: ' .. expanded)
end

vim.api.nvim_set_keymap('n', 'gcr', ':lua ExportExpandToClipboard()<CR>', { noremap = true })


local function check_spelling()
    -- 保存当前文件
    vim.cmd('write')

    -- 获取当前文件的路径
    local current_file = vim.fn.expand('%')

    -- 构建CSpell命令
    local command = 'cspell --config /Users/onns/.onns/weiyun/code/config/vim/cspell.yaml ' .. current_file

    -- 在新的终端窗口中执行CSpell
    vim.cmd('split | terminal ' .. command)
end

-- 将Lua函数绑定到Neovim命令
vim.api.nvim_create_user_command('SpellCheck', check_spelling, {})

vim.api.nvim_set_keymap('n', '<leader>pj',
    [[:.s/\v(\w+) (\w+) \= (\d+);/\1 \2 = \3 [(gogoproto.jsontag) = '\2', json_name = '\2'];<CR>]],
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pf',
    [[:.s/\v(\w+) (\w+) \= (\d+);/\1 \2 = \3 [(gogoproto.moretags) = 'form:"\2"',(gogoproto.jsontag) = '\2', json_name = '\2'];<CR>]],
    { noremap = true, silent = true })
