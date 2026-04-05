return {
  { "mistricky/codesnap.nvim",
    build = "make",
    config = function()
      require("codesnap").setup({
        has_breadcrumbs = true,
        has_line_number = true,
        bg_theme = "grape",
        bg_color = "#7da6ff",
        watermark = "",
      })
    end
  }
};
