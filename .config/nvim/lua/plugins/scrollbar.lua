return {
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      show = true,
      show_in_active_only = true,
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
      },
    },
  },
}
