return {
  "nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    cmp.setup({
      snippets = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "emoji" },
      },
    })
  end,
}
