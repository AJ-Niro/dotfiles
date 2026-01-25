return {
  -- ===========================================================
  -- Theme Selection
  -- ===========================================================
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  -- ===========================================================
  -- Spell Checking
  -- ===========================================================
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "cspell-lsp",
      },
    },
  },
  -- ===========================================================
  -- Display Scrollbar
  -- ===========================================================
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
