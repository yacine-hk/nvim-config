-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'ryanoasis/vim-devicons',
    'nvim-lualine/lualine.nvim',
    'mbbill/undotree',

    "lervag/vimtex",

    {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },

    {
      "mfussenegger/nvim-lint",
      event = {
        "BufReadPre",
        "BufNewFile",
      }
    },

    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },

    {
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
    },

    {
      'nvim-telescope/telescope.nvim',
      dependencies = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' }, { 'sharkdp/fd' } }
    },

    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" }
    },

    "gbprod/yanky.nvim",

    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" }, -- Required
        {                            -- Optional
          "williamboman/mason.nvim",
          build = function()
            pcall(vim.cmd, "MasonUpdate")
          end,
        },
        { "williamboman/mason-lspconfig.nvim" }, -- Optional

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },     -- Required
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
        { "L3MON4D3/LuaSnip" },     -- Required
        { "rafamadriz/friendly-snippets" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "saadparwaiz1/cmp_luasnip" },
      }
    },
    "https://github.com/mhartington/formatter.nvim",
    -- debugger
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        {
          "rcarriga/nvim-dap-ui",
          "nvim-neotest/nvim-nio",
          config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dap.set_log_level('INFO')
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
              dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
              dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
              dapui.close({})
            end
          end,
        },
        {
          "leoluz/nvim-dap-go",
          config = function()
            require("dap-go").setup()
          end,
        },
      },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "delve",
        },
      },

    },

    -- default tree (netrw)
    'prichrd/netrw.nvim',

    -- THEMES
    --   'ellisonleao/gruvbox.nvim'
    'Mofiqul/vscode.nvim',

    'ThePrimeagen/vim-be-good',
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
