-- general
lvim.log.level = "info"
  lvim.format_on_save = true
lvim.lint_on_save = true
-- lvim.colorscheme = "onedarker"
lvim.colorscheme = "tokyonight"

lvim.origstdpath = vim.fn.stdpath

vim.fn.stdpath = function(pathtype)
  if pathtype == 'cache' then
    return os.getenv "HOME" .. "/.cache/lvim"
  elseif pathtype == "config" then
    return os.getenv "HOME" .. "/.config/lvim"
  elseif pathtype == "data" then
    return os.getenv "HOME" .. "/.local/share/lunarvim"
  else
    return lvim.origstdpath(pathtype)
  end
end

-- options
local M = {}
M.load_options = function()
    local LVIM_CACHE_DIR = os.getenv "HOME" .. "/.cache/lvim"
    local myopts = {
        completeopt = {"menuone", "noselect"},
        hlsearch = false,
        autochdir = true,
        backupdir = LVIM_CACHE_DIR .. "/backup",
        undodir = LVIM_CACHE_DIR .. "/undo", -- set an undo directory
        undofile = true, -- enable persistent undo
        directory = LVIM_CACHE_DIR .. "/swap",
        writebackup = true, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
        spell = true
    }
    vim.cmd "set wildmode=longest,list"
    vim.cmd "set wildignore+=*/.idea/*"
    vim.cmd "set wildignore+=*/.git/*"
    vim.cmd "set wildignore+=*/.svn/*"
    vim.cmd "set wildignore+=*/vendor/*"
    vim.cmd "set wildignore+=*/node_modules/*"
    vim.cmd "set wildmode=longest,list"

    for k, v in pairs(myopts) do vim.opt[k] = v end
end

M.load_options()

lvim.puts = function(varname) print(vim.inspect(varname)) end

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode[",nt"] = ":NvimTreeToggle<CR>"
lvim.keys.insert_mode["<M-v>"] = "<Esc>pi"
vim.cmd("cnoremap <C-a> <Home>")
vim.cmd("cnoremap <C-e> <End>")

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
lvim.builtin.telescope.on_config_done = function()
    local actions = require "telescope.actions"
    -- for input mode
    lvim.builtin.telescope.defaults.mappings.i["<C-j>"] =
        actions.move_selection_next
    lvim.builtin.telescope.defaults.mappings.i["<C-k>"] =
        actions.move_selection_previous
    lvim.builtin.telescope.defaults.mappings.i["<C-n>"] =
        actions.cycle_history_next
    lvim.builtin.telescope.defaults.mappings.i["<C-p>"] =
        actions.cycle_history_prev
    -- for normal mode
    lvim.builtin.telescope.defaults.mappings.n["<C-j>"] =
        actions.move_selection_next
    lvim.builtin.telescope.defaults.mappings.n["<C-k>"] =
        actions.move_selection_previous
end

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = {
    "<cmd>Telescope projects<CR>", "Projects"
}
lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = {"<cmd>Trouble lsp_references<cr>", "References"},
    f = {"<cmd>Trouble lsp_definitions<cr>", "Definitions"},
    d = {"<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss"},
    q = {"<cmd>Trouble quickfix<cr>", "QuickFix"},
    l = {"<cmd>Trouble loclist<cr>", "LocationList"},
    w = {"<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss"}
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = false

lvim.lsp.diagnostics.virtual_text = true
-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
lvim.lang.python.formatters = {{exe = "black", args = {}}}
lvim.lang.python.linters = {{exe = "flake8", args = {}}}

lvim.lang.lua.formatters = {
    {exe = "stylua", args = {"--config-path", "~/.stylua.toml"}},
    {exe = "lua_format", args = {"-c", "~/.lua-format.cfg"}}
}
lvim.lang.lua.linters = {{exe = "luacheck"}}

lvim.lang.sh.formatters = {
    {exe = "shfmt", args = {"-w", "-ci", "-s", "-kp", "-i 2"}}
}
lvim.lang.sh.linters = {{exe = "shellcheck", args = {}}}

lvim.lang.javascript.formatters = {{exe = "prettier"}}
lvim.lang.javascript.linters = {{exe = "eslint"}}
lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters
lvim.lang.javascriptreact.linters = lvim.lang.javascript.linters

--
-- Additional Plugins
lvim.plugins = {
  {"folke/tokyonight.nvim"},
  {"folke/trouble.nvim", cmd = "TroubleToggle"},
  {"blackCauldron7/surround.nvim",
    config = function()
            require("surround").setup {
                -- mappings_style = "surround",
                mappings_style = "sandwich",
                pairs = {
                    nestable = {
                        {"(", ")"}, {"[", "]"}, {"<", ">"}, {"{", "}"},
                        {"<!--", "-->"}
                    },
                    linear = {{'"', '"'}, {"'", "'"}}
                },
                load_keymaps = true,
                load_autogroups = false
            }
        end
    }, -- { "tpope/vim-surround", keys = { "c", "d", "y" }, opt = true },
    {
        "folke/lua-dev.nvim",
        config = function()
            local luadev = require("lua-dev").setup {
                lspconfig = lvim.lang.lua.lsp.setup
            }
            lvim.lang.lua.lsp.setup = luadev
        end
    },
    {
     'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end
    },
}

--   {
--     "ray-x/lsp_signature.nvim",
--     config = function()
--       require("lsp_signature").on_attach()
--     end,
--     event = "InsertEnter",
--   }
-- },
-- {
-- 	    "ackyshake/Spacegray.vim",
--	    config = function() vim.cmd "Spacegray.vim".on_attach() end,
--     	    event = "InsertEnter"
-- },

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- vim: ft=lua
