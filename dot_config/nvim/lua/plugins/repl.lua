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

  -- silent conversion of notebooks to flat text
  {
    "goerz/jupytext.vim",
    init = function ()
      vim.g.jupytext_fmt = "md"
    end,
  },
}
