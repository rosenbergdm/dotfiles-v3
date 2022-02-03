--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
-- general
lvim.log.level = "info"
lvim.format_on_save = true
lvim.lint_on_save = true
-- lvim.colorscheme = "tokyonight"
lvim.colorscheme = "onedarker"
lvim.builtin.sell_soul_to_devel = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

local M = {}
M.load_options = function()
  local LVIM_CACHE_DIR = os.getenv "HOME" .. "/.cache/lvim"
  local myopts = {
    completeopt = { "menuone", "noselect" },
    hlsearch = false,
    autochdir = true,
    backupdir = LVIM_CACHE_DIR .. "/backup",
    undodir = LVIM_CACHE_DIR .. "/undo", -- set an undo directory
    undofile = true, -- enable persistent undo
    directory = LVIM_CACHE_DIR .. "/swap",
    writebackup = true, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    spell = true,
    foldmethod = "marker",
  }
  vim.cmd "set wildmode=longest,list"
  vim.cmd "set wildignore+=*/.idea/*"
  vim.cmd "set wildignore+=*/.git/*"
  vim.cmd "set wildignore+=*/.svn/*"
  vim.cmd "set wildignore+=*/vendor/*"
  vim.cmd "set wildignore+=*/node_modules/*"
  vim.cmd "set wildmode=longest,list"

  for k, v in pairs(myopts) do
    vim.opt[k] = v
  end
end

M.load_options()

lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode[",nt"] = ":NvimTreeToggle<CR>"
lvim.keys.normal_mode[",gd"] = ":cd %:p:h<CR>%"
lvim.keys.insert_mode["<M-v>"] = "<Esc>pi"
lvim.keys.visual_mode["<M-c>"] = "y"
vim.cmd "cnoremap <C-a> <Home>"
vim.cmd "cnoremap <C-e> <End>"
-- lvim.keys.visual_block_mode[""] = "y"
vim.cmd "vmap <C-S-c> y"
vim.cmd "xmap <C-S-c> y"
vim.cmd "vmap <M-c> y"
vim.cmd "xmap <M-c> y"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.lualine.sections.lualine_y = { "location" }
-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  {
    command = "prettier",
    args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact", "javascript" },
  },
  { command = "shfmt", filetypes = { "sh" } },

  {
    command = "stylua",
    -- args = { "--config-path", "~/.stylua.toml", "-s", "-" },
    -- args = { "--config-path", "~/.stylua.toml"},
    filetypes = { "lua" },
  },
}

linters.setup {
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  -- { command = "black", filetypes = { "python" } },
  { command = "luacheck", filetypes = { "lua" } },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  {
    "blackCauldron7/surround.nvim",
    config = function()
      require("surround").setup {
        -- mappings_style = "surround",
        mappings_style = "sandwich",
        pairs = {
          nestable = {
            { "(", ")" },
            { "[", "]" },
            { "<", ">" },
            { "{", "}" },
            { "<!--", "-->" },
          },
          linear = { { '"', '"' }, { "'", "'" } },
        },
        load_keymaps = true,
        load_autogroups = false,
      }
    end,
  },
  -- {
  --   "tpope/vim-surround",
  --   keys = { "c", "d", "y" },
  --   opt = true
  -- },
  {
    "vim-scripts/dbext.vim",
    { opt = true },
  },

  {
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    "gelfand/copilot.vim",
    disable = false,
    config = function()
      -- copilot assume mapped
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = false
    end,
  },
  {
    "hrsh7th/cmp-copilot",
    disable = not lvim.builtin.sell_soul_to_devel,
    config = function()
      lvim.builtin.cmp.formatting.source_names["copilot"] = "(Cop)"
      table.insert(lvim.builtin.cmp.sources, { name = "copilot" })
    end,
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = { { "BufWinEnter", "*", "chdir %:p:h" } }

-- My function defs
lvim.puts = function(varname)
  print(vim.inspect(varname))
end

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
