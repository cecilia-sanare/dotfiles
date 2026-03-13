return {
  "notjedi/nvim-rooter.lua",
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = { ".git", ".hg", ".svn" },
      trigger_patterns = { "*" },
      exclude_filetypes = { "oil" },
      manual = false,
    })

    -- Trigger immediately on startup
    vim.cmd("Rooter")
  end
}
