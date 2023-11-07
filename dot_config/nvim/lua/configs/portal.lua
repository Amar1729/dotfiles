-- maps and functionality for portal and associated movement plugins (grapple, and maybe harpoon?)
local portal = require("portal")
local builtin = require("portal.builtin")

-- grapple
vim.keymap.set("n", "<leader>t", require("grapple").toggle, { desc = "GrappleToggle a file" })

-- portal

-- in general, four labels are enough.
-- (however, we might override this for searches that need more labels)
portal.setup({
  labels = { "j", "k", "l", "h" },
})

local project_filter = function (v)
  local root_files = vim.fs.find({ ".git" }, { upward = true })
  if #root_files > 0 then
    local root_dir = vim.fs.dirname(root_files[1])
    if root_dir == nil then return false end
    local file_path = vim.api.nvim_buf_get_name(v.buffer)
    -- don't match git commit messages (sometimes i make this via fugitive or git commit -a)
    if string.match(file_path, "%.git/COMMIT_EDITMSG$") ~= nil then return false end
    return string.find(file_path, root_dir, 1, true) ~= nil
  end
  return true
end

-- provide jumplist, quickfix, and grapple results in one action.
-- this function might take some tweaking:
--   i'm still not sure about how many quickfixes to include (or whether to limit them to the same file?)
local full_query = function (direction)
  local jumplist_query = builtin.jumplist.query({
    direction = direction,
    filter = project_filter,
    labels = { "j", "k", "l" },
    max_results = 3,
  })

  local quickfix_query = builtin.quickfix.query({
    direction = direction,
    filter = function (v)
      -- filter results to current buffer and/or tagged by grapple

      -- can i filter to only quickfix entries that are later in the file than
      -- current cursor location? (get with :call line('.'))

      local buf_ok = function(bufnr)
        if vim.fn.buflisted(bufnr) == 1 then
          return true
        end

        if require("grapple").exists({ buffer = bufnr }) then
          return true
        end

        return false
      end

      if not buf_ok(v.buffer) then return false end

      -- ignore any entries that are before where our cursor currently is
      if v.buffer == vim.fn.bufnr() and v.cursor.row <= vim.fn.line('.') then
        return false
      end

      -- filter only for results that are severity E(rror)
      for _, err in ipairs(vim.fn.getqflist()) do
        if err.bufnr == v.buffer and err.col == v.cursor.col and err.lnum == v.cursor.row then
          if err.type == "E" then
            return true
          end
        end
      end

      return false
    end,
    labels = { "f", "d", "s" },
    max_results = 2,
  })

  local grapple_query = builtin.grapple.query({ labels = { "g", "h" }, max_results = 2 })

  portal.setup({
    labels = { "j", "k", "l", "f", "d", "s", "g", "h" },
  })
  portal.tunnel(
    {
      jumplist_query,
      quickfix_query,
      grapple_query,
    }
  )
end

vim.keymap.set(
  "n",
  "<leader>o",
  function ()
    builtin.jumplist.tunnel_backward({ filter = project_filter })
  end,
  { desc = "Portal: backward (in project)" }
)

vim.keymap.set(
  "n",
  "<leader>i",
  function ()
    builtin.jumplist.tunnel_forward({ filter = project_filter })
  end,
  {desc = "Portal: forward (in project)" }
)

vim.keymap.set(
  "n",
  "<Space>o",
  function ()
    full_query("backward")
  end,
  { desc = "Portal: backward (jumplist + quickfix + grapple)" }
)

vim.keymap.set(
  "n",
  "<Space>i",
  function ()
    full_query("forward")
  end,
  { desc = "Portal: forward (jumplist + quickfix + grapple)" }
)
