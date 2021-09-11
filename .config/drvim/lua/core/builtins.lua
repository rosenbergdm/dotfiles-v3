local M = {}
-- M.interface = {}
-- M.builtins = {}
-- M.plugin_cfg = {}
-- M.plugin_mappings = {}
-- M.default_plugins = {}

M.builtins = {}
M.builtins.plugins = {
    {"wbthomason/packer.nvim"}, {"neovim/nvim-lspconfig", opt = false},
    {"folke/tokyonight.nvim", opt = false }, {"tamago324/nlsp-settings.nvim", opt = false}, {
        "kyazdani42/nvim-tree.lua",
        -- event = "BufWinOpen",
        -- cmd = "NvimTreeToggle",
        -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
        config = function() require("core.config.nvimtree").setup() end
        -- disable = not lvim.builtin.nvimtree.active,
    }
}

local use = drvim.packer.use

for _, plugin in ipairs(M.builtins.plugins) do use(plugin) end

return M
