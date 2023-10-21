return {
    {
        'neoclide/coc.nvim',
        branch = 'master',
        build = "yarn install --frozen-lockfile",
    },
    {
        'onns/bookmarks.nvim',
        keys = {
            { "<tab><tab>", mode = { "n" } },
        },
        branch = 'main',
        dependencies = { 'nvim-web-devicons' },
        config = function()
            require("bookmarks").setup()
            require("telescope").load_extension("bookmarks")
        end
    },
    -- {
    --     "scrooloose/nerdtree",
    --     keys = {
    --         {
    --             "<leader>e",
    --             "<cmd>NERDTreeToggle<cr>",
    --             desc = "NERDTreeToggle"
    --         },
    --         {
    --             "<leader>v",
    --             "<cmd>NERDTreeFind<cr>",
    --             desc = "NERDTreeFind"
    --         }
    --     },
    --     config = function()
    --         require("neo-tree").setup()
    --     end
    -- },
    {
        "navarasu/onedark.nvim",
        config = function()
            require('onedark').setup {
                style = 'darker'
            }
            require('onedark').load()
        end
    },
    {
        'fatih/vim-go'
    },
    {
        "junegunn/fzf"
    },
    {
        "majutsushi/tagbar",
        keys = {
            {
                "<leader>t",
                "<cmd>TagbarToggle<cr>",
                desc = "TagbarToggle"
            }
        }
    },
    {
        "mhinz/vim-startify"
    }
}
