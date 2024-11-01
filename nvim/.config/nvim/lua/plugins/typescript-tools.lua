return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  config = function()
    require("typescript-tools").setup({
      handers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          virtual_text = true,
          signs = true,
          update_in_insert = true,
        }),
      }
    })
  end,
}
