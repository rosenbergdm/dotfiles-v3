-- Bootstrap the configuration process
Drvim = { builtin = {}, plugins = {} }

_G.HOME_PATH = vim.loop.os_homedir()
-- _G.DATA_PATH = vim.loop.os_getenv "Drvim_DATA_PATH"
-- _G.CACHE_PATH = _G.DATA_PATH .. "/cache"
-- _G.CONFIG_PATH = vim.loop.os_getenv "Drvim_CONFIG_PATH"
-- _G.RUNTIME_PATH = vim.loop.os_getenv "Drvim_RUNTIME_PATH"

vim.fn.old_stdpath = vim.fn.stdpath

vim.fn.stdpath = function(what)
  if what == "cache" then
    return _G.CACHE_PATH
  elseif what == "config_dirs" then
    return vim.fn.old_stdpath "config_dirs"
  elseif what == "data" then
    return _G.DATA_PATH
  elseif what == "data_dirs" then
    return vim.fn.old_stdpath "data_dirs"
  elseif what == "config" then
    return _G.CONFIG_PATH
  else
    return
  end
end

vim.opt.rtp:append(_G.RUNTIME_PATH)
vim.opt.rtp:append(_G.CONFIG_PATH)

vim.opt.rtp:remove(_G.HOME_PATH .. "/.local/share/nvim/site")
vim.opt.rtp:remove(_G.HOME_PATH .. "/.local/share/nvim/site/after")
vim.opt.rtp:prepend(_G.CONFIG_PATH .. "/site")
vim.opt.rtp:append(_G.CONFIG_PATH .. "/site/after")

vim.opt.rtp:remove(vim.fn.old_stdpath "config")
vim.opt.rtp:remove(vim.fn.old_stdpath "config" .. "/after")
vim.opt.rtp:prepend(_G.CONFIG_PATH)
vim.opt.rtp:append(_G.RUNTIME_PATH)
vim.opt.rtp:append(_G.RUNTIME_PATH .. "/site")
vim.opt.rtp:append(_G.CONFIG_PATH)
vim.opt.rtp:append(_G.CONFIG_PATH .. "/after")
vim.opt.rtp:append(_G.DATA_PATH .. "/site")

vim.cmd [[let &packpath = &runtimepath]]

Drvim.options = require "core.options"
Drvim.options:load_options()
vim.cmd "colorscheme tokyonight"
Drvim.packer = require "core.packerInit"
Drvim.packer.init()
Drvim.builtins = require "core.builtins"

Drvim.core_modules = {
  -- "core.options",
  -- "core.builtins",
  "core.plugins",
  "core.mappings",
}
Drvim.p = function(x)
  print(vim.inspect(x))
end

for _, module in ipairs(Drvim.core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end
