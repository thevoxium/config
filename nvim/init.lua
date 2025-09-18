vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
local repo = "https://github.com/folke/lazy.nvim.git"
vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
{
"NvChad/NvChad",
lazy = false,
branch = "v2.5",
import = "nvchad.plugins",
},
{

'ThePrimeagen/vim-be-good',
lazy = false,
},

 
{ import = "plugins" },
{
"inkdrop",
dir = "~/inkdrop",  -- Path to your plugin folder
lazy = false,
dependencies = { "nvim-lua/plenary.nvim",
"MeanderingProgrammer/render-markdown.nvim"},
config = function()
require('inkdrop').setup()
end
},
}, lazy_config)

vim.opt.number = true
vim.opt.relativenumber = true

vim.o.scrolloff = 999

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)


vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})


--- different color theme, delete if dont like
---
-- Disable syntax highlighting


vim.o.cmdheight = 0

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
require "mappings"
end)
