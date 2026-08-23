return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]], -- Ctrl+\ to toggle
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true, -- Apply mapping in insert mode
      terminal_mappings = true, -- Apply mapping in terminal mode
      persist_size = true,
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
        width = math.floor(vim.o.columns * 0.9),
        height = math.floor(vim.o.lines * 0.9),
        winblend = 3,
      },
    },
    keys = {
      -- Multiple terminals (numbered)
      { "<leader>t1", "<cmd>1ToggleTerm<cr>", desc = "Toggle terminal 1" },
      { "<leader>t2", "<cmd>2ToggleTerm<cr>", desc = "Toggle terminal 2" },
      { "<leader>t3", "<cmd>3ToggleTerm<cr>", desc = "Toggle terminal 3" },
      { "<leader>t4", "<cmd>4ToggleTerm<cr>", desc = "Toggle terminal 4" },
    },
  },
}
