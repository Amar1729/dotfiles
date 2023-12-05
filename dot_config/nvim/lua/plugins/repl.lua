-- REPL / code-runner plugins.

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-notify",
    },
    ft = { "http" },
    opts = true,
  },
}
