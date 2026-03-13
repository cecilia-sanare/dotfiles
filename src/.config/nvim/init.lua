local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Handle opening a github repo at its root
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    local path = arg:gsub("^oil://", "")
    if vim.fn.isdirectory(path) == 1 then
      local git = vim.fn.finddir(".git", path)
      if git ~= "" then
        vim.cmd("cd " .. vim.fn.fnamemodify(path, ":p"))
      end
    end
  end,
})

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- Leader key
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>t", "<cmd>split | terminal<cr>")

require("lazy").setup("plugins")
