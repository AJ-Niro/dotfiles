return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            file_ignore_patterns = {
              "node_modules",
              ".git/",
              "dist/",
            },
          })
        end,
      },
    },
  },
}
