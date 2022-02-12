vim.g.R_assign = 2
vim.cmd [[PackerLoad Nvim-R]]

local lspservers = { "r_language_server" }
for _, lspserver in pairs(lspservers) do
  require("lspconfig")[lspserver].setup {}
end

require("lvim.lsp.manager").setup "r_language_server"
