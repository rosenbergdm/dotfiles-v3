--[[
lvim is the global options object
--]]

-- general

lvim.log.level = "debug"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"
lvim.builtin.sell_soul_to_devel = true

lvim.myhelp = {}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

--[[
CMD-c copying in insert / visual mode hack
For this to work the way I want,
  1.) iTerm2 is set to emit the escape sequence \[eC (esc-c) for CMD-c
  2.) Readline is configured (via .inputrc) to map as follows:
     set key map vi-insert
     $if Bash
       "^[c": "\C-yii"
     $else
     ...
  3.) The visual map lvim.keys.visual_mode["<M-c>"] = "y"
--]]
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<M-c>"] = "y"
lvim.keys.visual_mode["<M-c>"] = "y"
lvim.keys.visual_block_mode["<M-c>"] = "y"
lvim.keys.insert_mode["√"] = "<esc>:PasteImg<CR>o"

local M = {}
M.load_options = function()
  local LVIM_CACHE_DIR = os.getenv "HOME" .. "/.cache/lvim"
  local myopts = {
    completeopt = { "menuone", "noselect" },
    hlsearch = false,
    autochdir = true,
    backupdir = LVIM_CACHE_DIR .. "/backup",
    undodir = LVIM_CACHE_DIR .. "/undo",
    undofile = true,
    directory = LVIM_CACHE_DIR .. "/swap",
    writebackup = true,
    spell = true,
    foldmethod = "marker",
    wrap = true,
    cmdheight = 4,
    swapfile = true,
    backup = true,
    -- guifont = "Monaco:h14",
    guifont = "DroidSansMono Nerd Font Mono:h14",
    -- guifont = "ProFontIIx Nerd Font Mono:h14",
    -- guifont = "Inconsolata Nerd Font Mono:h14",
    foldenable = false,
    modeline = true,
    list = true,
    modelines = 5,
  }
  vim.cmd "set wildmode=longest,list"
  vim.cmd "set wildignore+=*/.idea/*"
  vim.cmd "set wildignore+=*/.git/*"
  vim.cmd "set wildignore+=*/.svn/*"
  vim.cmd "set wildignore+=*/vendor/*"
  vim.cmd "set wildignore+=*/node_modules/*"
  vim.cmd "set wildmode=longest,list"
  vim.g.python3_host_prog = "/Users/dmr/.pyenv/versions/3.10.2/bin/python3.10"
  -- vim.cmd "let R_assign=0"

  for k, v in pairs(myopts) do
    vim.opt[k] = v
  end
end

M.load_options()

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode[",nt"] = ":NvimTreeToggle<CR>"
lvim.keys.normal_mode[",gd"] = ":cd %:p:h<CR>%"
lvim.keys.insert_mode["<M-v>"] = "<Esc>pi"
lvim.keys.visual_mode["<M-c>"] = "y"
vim.cmd "cnoremap <C-a> <Home>"
vim.cmd "cnoremap <C-e> <End>"
lvim.keys.visual_block_mode[""] = "y"
vim.cmd "vmap <C-S-c> y"
vim.cmd "xmap <C-S-c> y"
vim.cmd "vmap <M-c> y"
vim.cmd "xmap <M-c> y"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

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
lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.update_cwd = false

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

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
lvim.builtin.dap.active = true
lvim.builtin.bufferline.active = true
lvim.builtin.gitsigns.active = false
lvim.builtin.project.manual_mode = true

-- generic LSP settings

lvim.lsp.diagnostics.virtual_text = true
lvim.lsp.code_lens_refresh = true

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = true

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- require("lvim.lsp.manager").setup("pylsp", {})

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
lvim.lsp.on_attach_callback = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "black",
    filetypes = { "python" },
  },
  {
    command = "isort",
    filetypes = { "python" },
  },
  {
    command = "prettier",
    args = { "--print-width", "100" },
    extra_args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact", "javascript" },
  },
  {
    command = "shfmt",
    extra_args = { "-i", "2", "-s" },
    filetypes = { "sh" },
  },
  {
    command = "stylua",
    -- args = { "--config-path", "~/.stylua.toml", "-s", "-" },
    -- args = { "--config-path", "~/.stylua.toml" },
    filetypes = { "lua" },
  },
}

linters.setup {
  {
    command = "shellcheck",
    -- extra_args = { "--line-width", "120" },
    -- args = { "--line-width", "120" },
    filetypes = { "sh", "bash", "shell", "zsh" },
  },
  { command = "stylelint", filetypes = { "css", "scss" } },
  { command = "luacheck", filetypes = { "lua" } },
  {
    command = "codespell",
    filetypes = { "javascript", "python" },
  },
}
lvim.plugins = {
  { "folke/tokyonight.nvim", rocks = { "see" } },
  {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "oberblastmeister/neuron.nvim" },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
  },
  {
    "ur4ltz/surround.nvim",
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
  {
    "vim-scripts/dbext.vim",
    opt = true,
  },

  {
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          ---@diagnostic disable-next-line: undefined-global
          plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
        }
      end, 100)
    end,
  },
  { "zbirenbaum/copilot-cmp", after = { "copilot.lua", "nvim-cmp" } },
  {
    "ekickx/clipboard-image.nvim",
    disable = false,
    config = function()
      require("clipboard-image").setup {
        -- Default configuration for all filetype
        default = {
          img_dir = os.getenv "HOME" .. "/tmp",
          img_name = function()
            return os.date "%Y-%m-%d-%H-%M-%S"
          end, -- Example result: "2021-04-13-10-04-18"
          -- affix = "<\n  %s\n>" -- Multi lines affix
        },
        -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
        -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
        -- Missing options from `markdown` field will be replaced by options from `default` field
        asciidoc = {
          img_dir = { "img" },
          affix = "image::%s[align=center,width=75%%]",
        },
        markdown = {
          img_dir = { "img" }, -- Use table for nested dir (New feature form PR #20)
          -- img_dir_txt = "img",
        },
      }
    end,
  },
  -- {
  --   "shuntaka9576/preview-asciidoc.nvim",
  --   config = function()
  --     vim.g.padoc_node_path = "/Users/dmr/.nvm/versions/node/v16.10.0/bin/node"
  --     vim.g.padoc_build_command = "/Users/dmr/.rvm/gems/ruby-3.0.2/bin/asciidoctor"
  --   end,
  --   run = "yarn install",
  -- },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "jalvesaq/Nvim-R",
    opt = true,
    event = "BufEnter *.R",
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = {
      "mfussenegger/nvim-dap-python",
    },
  },

  {
    "kosayoda/nvim-lightbulb",
    opt = true,
    disable = true,
    -- This plugin seems to make the cursor problematic
    -- config = function()
    --   vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    -- end,
  },
  {
    "p00f/nvim-ts-rainbow",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
    disable = false,
    opt = false,
  },
  {
    "jghauser/kitty-runner.nvim",
    config = function()
      require("kitty-runner").setup()
    end,
  },

  {
    "npxbr/glow.nvim",
    ft = { "markdown" },
    run = "yay -S glow"
  },
  {
    "edluffy/hologram.nvim",
    config = function()
      lvim.myhelp.hologram = "https://github.com/edluffy/hologram.nvim"
    end,
  },
  {
    "ray-x/navigator.lua",
    requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make " },
  },
  {
    "sudormrfbin/cheatsheet.nvim",
    requires = {
      { "nvim-telescope/telescope.nvim" },

      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },
  {
    "Glench/Vim-Jinja2-Syntax",
  },
  -- Colorschemes
  { "tiagovla/tokyodark.nvim" },
  { "tjdevries/gruvbuddy.nvim", requires = { "tjdevries/colorbuddy.vim" } },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            "class",
            "function",
            "method",
          },
        },
      }
    end,
  },
}

-- launch the above scheme with ":lua require('colorbuddy').colorscheme('gruvbuddy')"

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter,BufRead,BufNewFile", "*", "chdir %:p:h" },
  { "BufWritePost", "*.adoc", ":!asciidoctor %" },
}
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("BufWinEnter,BufRead,BufNewFile", {
  pattern = { "*" },
  command = "chdir %:p:h",
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.adoc" },
  command = ":!asciidoctor '%'",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
-- lvim.dap = require("dap-python").setup "~/.config/virtualenvs/debugpy/bin/python"

lvim.ts = require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    custom_captures = {},
    additional_vim_regex_highlighing = true,
  },
  rainbow = {
    extended_mode = true,
    enable = true,
  },
}

-- local lspservers = { "r_language_server" }
-- for _, lspserver in pairs(lspservers) do
--   require("lspconfig")[lspserver].setup {}
-- end
vim.cmd "let g:firenvim_config = {'globalSettings': { }, 'localSettings': {'.*': { 'takeover': 'never'} } }"

-- -- My function defs
-- lvim.puts = function(varname)
--   print(vim.inspect(varname))
-- end

-- P = function(varname)
--   print(vim.inspect(varname))
-- You can print with :lua =XXXX
--   or use :lua =lvim.see(xxxx)

lvim.packer = require "packer"
require('lspconfig').tsserver.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    -- on_attach(client, bufnr)
  end,
}
