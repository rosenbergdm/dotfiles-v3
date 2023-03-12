--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"
lvim.builtin.sell_soul_to_devel = true

---@diagnostic disable-next-line: unused-local
local M = {}
---@diagnostic disable-next-line: unused-local
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
    number = true,
    wildmode = "longest,list",
    wildignore = "*/.idea/*",
  }
  -- vim.opt("set wildmode=longest,list")
  -- vim.cmd "set wildignore+=*/.idea/*"
  -- vim.cmd "set wildignore+=*/.git/*"
  -- vim.cmd "set wildignore+=*/.svn/*"
  -- vim.cmd "set wildignore+=*/vendor/*"
  -- vim.cmd "set wildignore+=*/node_modules/*"
  -- vim.cmd "set wildmode=longest,list"
  vim.g.python3_host_prog = "/Users/dmr/.pyenv/versions/3.10.2/bin/python3.10"
  -- vim.cmd "let R_assign=0"

  for k, v in pairs(myopts) do
    vim.opt[k] = v
  end
end

lvim.myhelp = {}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<M-c>"] = "y"
lvim.keys.visual_mode["<M-c>"] = "y"
lvim.keys.visual_block_mode["<M-c>"] = "y"
lvim.keys.insert_mode["√"] = "<esc>:PasteImg<CR>o"

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

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

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
-- -- Change theme settings
lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.update_cwd = false

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

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
-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.lsp.on_attach_callback = function(_, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end

--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

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
  -- {
  --   "goolord/alpha-nvim",
  --   -- dependencies = { "kyazdani42/nvim-web-devicons" },
  --   config = function()
  --     require("alpha").setup(require("alpha.themes.startify").config)
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    rocks = { "see" },
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
    lazy = true,
  },

  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    cmd = "Copilot",
    config = function()
      vim.schedule(function()
        require("copilot").setup()
      end)
    end,
  },
  { "zbirenbaum/copilot-cmp", after = { "copilot.lua", "nvim-cmp" } },
  {
    "ekickx/clipboard-image.nvim",
    enable = true,
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
  {
    "shuntaka9576/preview-asciidoc.nvim",
    config = function()
      vim.g.padoc_node_path = "/Users/dmr/.nvm/versions/node/v16.10.0/bin/node"
      vim.g.padoc_build_command = "/Users/dmr/.rvm/gems/ruby-3.0.2/bin/asciidoctor"
    end,
    build = "yarn install",
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "jalvesaq/Nvim-R",
    lazy = true,
    event = "BufEnter *.R",
  },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = {
  --     "mfussenegger/nvim-dap-python",
  --   },
  -- },

  {
    "kosayoda/nvim-lightbulb",
    lazy = true,
    enable = false,
    -- This plugin seems to make the cursor problematic
    -- config = function()
    --   vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    -- end,
  },
  {
    "p00f/nvim-ts-rainbow",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    enable = true,
    lazy = false,
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
    build = "yay -S glow",
  },
  {
    "edluffy/hologram.nvim",
    config = function()
      lvim.myhelp.hologram = "https://github.com/edluffy/hologram.nvim"
    end,
  },
  {
    "ray-x/navigator.lua",
    dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make " },
  },
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
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
  { "tjdevries/gruvbuddy.nvim", dependencies = { "tjdevries/colorbuddy.vim" } },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "JuliaEditorSupport/julia-vim",
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

vim.api.nvim_create_autocmd("BufWinEnter,BufRead,BufNewFile", {
  pattern = { "*" },
  command = "chdir %:p:h",
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.adoc" },
  command = ":!asciidoctor %",
})
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

lvim.P = function(varname)
  print(vim.inspect(varname))
end
-- You can print with :lua =XXXX
--   or use :lua =lvim.see(xxxx)

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
require("lspconfig").tsserver.setup {
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    -- on_attach(client, bufnr)
  end,
}
