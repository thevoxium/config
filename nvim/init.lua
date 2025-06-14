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
  "stevearc/conform.nvim", -- or use "mhartington/formatter.nvim"
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          cpp = { "clang_format" },
          c = { "clang_format" },
        },
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.cpp", "*.h", "*.c" },
        callback = function()
          require("conform").format()
        end,
      })
    end,
  },

  { import = "plugins" },

  {
  "yetone/avante.nvim",
    config = function()
      local opts = { provider = "openrouter" }

      -- local openai_api_url = "https://openrouter.ai/api/v1"
      -- local openai_api_url = "https://api.fireworks.ai/inference/v1/"
      local openai_api_url = "https://api.groq.com/openai/v1"
      if openai_api_url then
        opts.provider = "openai"
        opts.openai = {
          endpoint = openai_api_url,
          -- model = "deepseek/deepseek-chat-v3-0324",
          -- model = "anthropic/claude-3.7-sonnet",
          -- model = "anthropic/claude-sonnet-4",
             model = "qwen/qwen3-32b",
          -- model = "openai/o4-mini",
          timeout = 30000,
          api_key_name = "GROQ_API_KEY",
          temperature = 0,
          disable_tools = true,
        }
      end

      require("avante").setup(opts)
    end,
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = "openai",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Recommended Neovim option for avante.nvim
vim.opt.laststatus = 3
-- Add this after loading the statusline
-- Load avante_lib (recommended to do this after setting colorscheme)
vim.schedule(function()
  require("avante_lib").load()
end)

-- Enable true colors
vim.opt.termguicolors = true

-- Set background transparency
vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
vim.cmd [[highlight NonText guibg=NONE ctermbg=NONE]]

vim.o.scrolloff = 999
-- Other configurations...
