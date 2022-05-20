lvim.dap = require("dap-python").setup "~/.config/virtualenvs/debugpy/bin/python"

-- lvim.dap.adapters.python = {
--   type = "executable",
--   command = "/opt/homebrew/bin/python3",
--   args = { "-m", "debugpy.adapter" },
-- }

-- lvim.dap.configurations.python = {
--   {
--     type = "python",
--     request = "launch",
--     name = "Launch file",
--     program = "${file}",
--     pythonPath = function()
--       return "/opt/homebrew/bin/python3"
--     end,
--   },
-- }
