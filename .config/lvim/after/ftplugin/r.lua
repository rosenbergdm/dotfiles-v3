vim.g.R_assign = 2
vim.cmd [[PackerLoad Nvim-R]]

local lspservers = { "r_language_server" }
for _, lspserver in pairs(lspservers) do
  require("lspconfig")[lspserver].setup {}
end

-- local opts = {
--   on_attach = require("lvm.lsp").common_on_attach,
--   on_init = require("lvim.lsp").common_on_init,
--   capabilities = require("lvim.lsp").common_capabilities(),
-- }

require("lvim.lsp.manager").setup "r_language_server"
