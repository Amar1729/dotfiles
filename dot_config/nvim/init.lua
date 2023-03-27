-- Amar Paul's init.lua (for Neovim)

-- install and set up plugins
require "core.plugins_lazy"

-- settings / bindings (note that some are dependent on loaded plugins, e.g. bindings/highlights)
require "core.options"
require "core.autocmds"
require "core.mappings"
require "core.highlights"
