return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    ft = "python",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "debugpy",
      },
    },
  },
}
