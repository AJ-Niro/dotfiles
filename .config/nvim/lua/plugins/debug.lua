return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 35,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.30 },
            { id = "console", size = 0.70 },
          },
          size = 0.25,
          position = "bottom",
        },
      },
    },
  },
}
