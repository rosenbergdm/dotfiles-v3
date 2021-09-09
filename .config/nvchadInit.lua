local home_dir = vim.loop.os_homedir()

vim.opt.rtp:append(home_dir .. "/.local/share/nvcvim")
vim.opt.rtp:append(home_dir .. "/.config/nvim.ch")

vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site")
vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site/after")
vim.opt.rtp:prepend(home_dir .. "/.local/share/nvcvim/site")
vim.opt.rtp:append(home_dir .. "/.local/share/nvcvim/site/after")

vim.opt.rtp:remove(home_dir .. "/.config/nvim")
vim.opt.rtp:remove(home_dir .. "/.config/nvim/after")
vim.opt.rtp:prepend(home_dir .. "/.config/nvim.ch")
vim.opt.rtp:append(home_dir .. "/.config/nvim.ch")
vim.opt.rtp:append(home_dir .. "/.config/nvim.ch/after")

vim.cmd [[let &packpath = &runtimepath]]

-- print(vim.inspect(vim.opt.rtp))

local init_modules = {"core"}

for _, module in ipairs(init_modules) do
    local ok, err = pcall(require, module)
    if not ok then error("Error loading " .. module .. "\n\n" .. err) end
end

vim.fn.stdpath = function(what)
    if what == 'cache' then
        return (home_dir .. '/.cache/nvim.ch')
    elseif what == 'config_dirs' then
        return {}
    elseif what == 'data' then
        return (home_dir .. '/.local/share/nvim.ch')
    elseif what == 'data_dirs' then
        return ({"/usr/local/share/nvim", "/usr/share/nvim"})
    elseif what == 'config' then
        return (home_dir .. '/.config/nvim.ch')
    else
        return
    end
end
