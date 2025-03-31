require("config.lazy")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})

require('lint').linters_by_ft = {
    lua = { "ast_grep" }
}

-- require('fzf-lua').files()

require("mason").setup()
require("mason-lspconfig").setup()

require 'jabs'.setup {
    -- Options for the main window
    position = {'center', 'center'}, -- position = {'<position_x>', '<position_y>'} | <position_x> left, center, right,
                                  --                                             <position_y> top, center, bottom
                                  -- Default {'right', 'bottom'}

    relative = 'editor', -- win, editor, cursor. Default win
    clip_popup_size = false, -- clips the popup size to the win (or editor) size. Default true

    width = 80, -- default 50
    height = 20, -- default 10
    border = 'rounded', -- none, single, double, rounded, solid, shadow, (or an array or chars). Default shadow

--    offset = { -- window position offset
--        top = 2, -- default 0
--        bottom = 2, -- default 0
--        left = 2, -- default 0
--        right = 2, -- default 0
--    },

    sort_mru = true, -- Sort buffers by most recently used (true or false). Default false
    split_filename = true, -- Split filename into separate components for name and path. Default false
    split_filename_path_width = 20, -- If split_filename is true, how wide the column for the path is supposed to be, Default 0 (don't show path)

    -- Options for preview window
    preview_position = 'left', -- top, bottom, left, right. Default top
    preview = {
        width = 40, -- default 70
        height = 60, -- default 30
        border = 'single', -- none, single, double, rounded, solid, shadow, (or an array or chars). Default double
    },

    -- Default highlights (must be a valid :highlight)
    highlight = {
        current = "Title", -- default StatusLine
        hidden = "StatusLineNC", -- default ModeMsg
        split = "WarningMsg", -- default StatusLine
        alternate = "StatusLine" -- default WarningMsg
    },

    -- Default symbols
--    symbols = {
--        current = "C", -- default 
--        split = "S", -- default 
--        alternate = "A", -- default 
--        hidden = "H", -- default ﬘
--        locked = "L", -- default 
--        ro = "R", -- default 
--        edited = "E", -- default 
--        terminal = "T", -- default 
--        default_file = "D", -- Filetype icon if not present in nvim-web-devicons. Default 
--        terminal_symbol = ">_" -- Filetype icon for a terminal split. Default 
--    },

    -- Keymaps
    keymap = {
        close = "D", -- Close buffer. Default D
        jump = "<CR>", -- Jump to buffer. Default <cr>
        h_split = "h", -- Horizontally split buffer. Default s
        v_split = "v", -- Vertically split buffer. Default v
        preview = "p", -- Open buffer preview. Default P
    },

    -- Whether to use nvim-web-devicons next to filenames
    use_devicons = true -- true or false. Default true
}

require('mini.animate').setup()

require("tint").setup()

local org = require('orgmode')


require('cmp').setup({
  sources = {
    { name = 'orgmode' }
  }
})

vim.opt.cursorline = true
vim.wo.relativenumber = true
vim.wo.number = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#928374" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fe8019", bold = true })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Window Commands (Leader w)
vim.keymap.set("n", "<leader>|", ":vsplit<CR>",{ noremap = true })
vim.keymap.set("n", "<leader>wn", ":vsplit<CR><C-w>l",{ noremap = true })
vim.keymap.set("n", "<leader>wb", ":split<CR><C-w>j",{ noremap = true })
vim.keymap.set("n", "<leader>wd", ":close<CR>",{ noremap = true })
vim.keymap.set("n", "<leader>wh", "<C-w>h",{ noremap = true })
vim.keymap.set("n", "<leader>wj", "<C-w>j",{ noremap = true })
vim.keymap.set("n", "<leader>wk", "<C-w>k",{ noremap = true })
vim.keymap.set("n", "<leader>wl", "<C-w>l",{ noremap = true })

-- Buffer Commands (Leader b)
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>",{ noremap = true })
vim.keymap.set("n", "<leader>b!", ":bdelete!<CR>",{ noremap = true })
vim.keymap.set("n", "<leader>bn", ":enew<CR>",{ noremap = true })
vim.keymap.set("n", "<leader>bf", ":JABSOpen<CR>",{ noremap = true })
vim.keymap.set("n", "<leader>br", ":Dashboard<CR>",{ noremap = true })

-- File commands (Leader f)
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>",{ noremap = true })
