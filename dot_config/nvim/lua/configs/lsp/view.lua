local M = {}

-- Overrides floating window look with other border symbols.
function M.override()
  -- assign border -> border_chars
  -- override all floating windows with our new explicitly-defined border
  local border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
  local border = {}
  for i, char in pairs(border_chars) do
      border[i] = { char, "FloatBorder" }
  end

  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, fp_opts, ...)
    fp_opts = fp_opts or {}
    fp_opts.border = fp_opts.border or border
    return orig_util_open_floating_preview(contents, syntax, fp_opts, ...)
  end
end

M.override()

return M
