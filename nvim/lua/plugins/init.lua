return {
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},

{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = false},

{
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
theme = 'hyper',
    config = {
      week_header = {
       enable = true,
      },
      shortcut = {
        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Apps',
          group = 'DiagnosticHint',
          action = 'Telescope app',
          key = 'a',
        },
        {
          desc = ' dotfiles',
          group = 'Number',
          action = 'Telescope dotfiles',
          key = 'd',
        },
      },
    },
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
},

{ "nvim-tree/nvim-web-devicons", opts = {} },

{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {}
},
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "rust_analyzer" }, -- Add your desired LSPs
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.rust_analyzer.setup({})
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip", -- Completion for snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Linting
{
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    -- Explicitly define linters for each file type (without ast_grep)
    lint.linters_by_ft = {
      lua = { "luacheck" }, -- Use "luacheck" instead of "ast_grep"
      python = { "flake8" },
      javascript = { "eslint" },
      typescript = { "eslint" },
    }

    -- Check if ast_grep is accidentally registered and remove it
    lint.linters.ast_grep = nil

    -- Auto-run the linter only for the configured filetypes
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "!*.lua",
      callback = function()
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] then
          lint.try_lint()
        end
      end,
    })
  end,
},

-- autoformatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          python = { "black" },
        },
        format_on_save = true,
      })
    end,
  },

{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup({
      check_ts = true, -- Enable treesitter integration for better handling
      disable_filetype = { "TelescopePrompt", "vim" }, -- Disable in these filetypes
      fast_wrap = {}, -- Enable fast wrapping
    })

    -- Integrate with nvim-cmp (autocompletion)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
},

{"matbme/JABS.nvim"},

{
  'nvim-orgmode/orgmode',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-orgmode/telescope-orgmode.nvim',
    'nvim-orgmode/org-bullets.nvim',
  },
  event = 'VeryLazy',
  config = function()
    require('orgmode').setup({
      org_agenda_files = '~/orgfiles/agenda.org',
      org_default_notes_file = '~/orgfiles/refile.org',
    })
    require('org-bullets').setup()
    require('telescope').setup()
    require('telescope').load_extension('orgmode')
    vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading)
    vim.keymap.set('n', '<leader>ofh', require('telescope').extensions.orgmode.search_headings)
    vim.keymap.set('n', '<leader>oli', require('telescope').extensions.orgmode.insert_link)
  end,
},

{ 'echasnovski/mini.animate', version = false },

{"levouh/tint.nvim"},

{"hrsh7th/nvim-cmp"},

}
