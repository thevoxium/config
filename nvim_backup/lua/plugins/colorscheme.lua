return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      require('onedark').setup {
        style = 'dark', -- Options: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
      }
      require('onedark').load()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
