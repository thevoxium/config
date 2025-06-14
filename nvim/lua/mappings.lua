require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- LSP rename
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
      buffer = args.buf,
      desc = "LSP Rename",
      noremap = true,
      silent = true,
    })
  end,
})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
