-- autocmds.lua: core Neovim behavior only, no plugin dependencies

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local line = vim.fn.line([['"]])
    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- For Makefiles
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 8
  end,
})

-- -- ClangFormat --> this is now done by LSP
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "c", "cpp", "cxx", "C", "objc" },
--   callback = function()
--     vim.keymap.set("n", "<C-k>", ":ClangFormat<CR>", { buffer = true })
--     vim.keymap.set("v", "<C-k>", ":ClangFormat<CR>", { buffer = true })
--   end,
-- })

-- python formatting
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.py",
  callback = function()
    vim.opt.textwidth = 89
    vim.opt.colorcolumn = "89"
  end
})

-- javascript formatting
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.js", "*.html", "*.css", "*.lua"},
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end
})

-- highlight yanked text using the 'IncSearch' highlight group for 40ms
local HighlightYank = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = HighlightYank,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- remove trailing whitespace from all lines before saving a file)
local CleanOnSave = vim.api.nvim_create_augroup('CleanOnSave', {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = CleanOnSave,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Enable JSON folding
-- `zc` to close a fold
-- `zo` to open a fold
-- `za` to toggle a fold
-- `zR` to open all folds
-- `zM` to close all folds
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.json",
  callback = function()
    vim.opt_local.foldmethod = "syntax"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99  -- Start with all folds open
  end
})
