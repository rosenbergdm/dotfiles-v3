local home_dir = vim.loop.os_homedir()

vim.opt.rtp:append(home_dir .. "/.config/nvim.ch")
vim.opt.rtp:remove(home_dir .. "/.config/nvim")
vim.opt.rtp:append(home_dir .. "/.local/share/nvim.ch")
vim.opt.rtp:append(home_dir .. "/.local/share/nvim.ch/site")
vim.cmd [[let &packpath=&rtp]]

_G.HOME_PATH = vim.loop.os_homedir()
_G.DATA_PATH = _G.HOME_PATH .. "/.local/share/nvim.ch"
_G.CACHE_PATH = _G.DATA_PATH .. "/cache"
_G.CONFIG_PATH = _G.HOME_PATH .. "/.config/nvim.ch"
_G.RUNTIME_PATH = vim.loop.os_getenv "NVCVIM_RUNTIME_PATH"
-- _G.RUNTIME_PATH = vim.loop.os_getenv "DRVIM_RUNTIME_PATH"

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
-- vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site")
-- vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site/after")
-- vim.opt.rtp:prepend(home_dir .. "/.local/share/nvim.ch/site")
-- vim.opt.rtp:append(home_dir .. "/.local/share/nvim.ch/site/after")

-- vim.opt.rtp:remove(home_dir .. "/.config/nvim")
-- vim.opt.rtp:remove(home_dir .. "/.config/nvim/after")
-- vim.opt.rtp:prepend(home_dir .. "/.config/nvim.ch")
-- vim.opt.rtp:append(home_dir .. "/.config/nvim.ch")
-- vim.opt.rtp:append(home_dir .. "/.config/nvim.ch/after")

-- vim.opt.rtp:append(home_dir .. ".config/nvim.ch/lua")

-- vim.cmd [[packadd packer.nvim]]
-- print(vim.inspect(vim.opt.rtp))
-- print(vim.inspect(vim.opt.packpath))

-- '/Users/dmr/.config/nvim.ch,/Users/dmr/.config/nvim.ch/lua,/Users/dmr/.config/nvim.ch/lua,/Users/dmr/.local/share/nvim.ch/site,/etc/xdg/nvim,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/share/nvim/runtime,/usr/local/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/dmr/.config/nvim.ch/lua,/Users/dmr/.config/nvim.ch/plugin,/Users/dmr/.config/nvim.ch/after' ]]
--
local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

local core_modules = {
  "core.options",
  "core.autocmds",
  "core.mappings",
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end

-- non plugin mappings
require("core.mappings").misc()

-- check if custom init.lua file exists
if vim.fn.filereadable(vim.fn.stdpath "config" .. "/lua/custom/init.lua") == 1 then
  -- try to call custom init, if not successful, show error
  local ok, err = pcall(require, "custom")
  if not ok then
    vim.notify("Error loading custom/init.lua\n\n" .. err)
  end
  return
end
