-- neodev, for setting vim.*
require('neodev').setup({
    -- add chezmoi dir to the directories that need vim.* docs from neodev.nvim
    override = function(root_dir, library)
        if require('neodev.util').has_file(root_dir, os.getenv('HOME') .. '/.local/share/chezmoi') then
            library.enabled = true
            library.plugins = true
        end
    end
})
