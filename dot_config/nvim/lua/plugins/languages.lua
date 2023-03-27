-- ---- Language-specific syntax support, completions:

local check_os = function(target)
    local uname = vim.api.nvim_command_output("!uname -s")
    if uname:find(target) then
      return true
    else
      return false
    end
end

return {
  -- vim wiki
  {
    "vimwiki/vimwiki",
    keys = {
      { "<leader>ww" },
      { "2<leader>ww" },
    },
    init = function()
      vim.cmd([[
        let wiki_1 = {}
        let wiki_1.path = '~/Dropbox/wiki/'
        "let wiki_1.html_template = '~/public_html/template.tpl'
        "let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}

        let wiki_2 = {}
        let wiki_2.path = '~/Documents/Personal/work_wiki/'
        "let wiki_2.index = 'main'

        let g:vimwiki_list = [wiki_1, wiki_2]
      ]])
    end,
  },

  -- chezmoi templating/support
  "alker0/chezmoi.vim",

  -- sxhkd
  {
    "kovetskiy/sxhkd-vim",
    cond = check_os("Linux"),
  },

  -- skhd
  {
    "amar1729/skhd-vim-syntax",
    ft = { "skhd" },
    cond = check_os("Darwin"),
  },

  -- database access + ui
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",

  -- nice completion of xhtml tags
  "tpope/vim-ragtag",

  -- antlr files (.g4 and .g3)
  "dylon/vim-antlr",

  -- powershell (ugh)
  {
    "PProvost/vim-ps1",
    ft = { "ps1" },
  },
}
