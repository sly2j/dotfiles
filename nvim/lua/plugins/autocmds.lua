-- plugins/autocmds.lua: autocmds that depend on external tools or plugins

-- LSP format-on-save per filetype and per LSP server.
-- Only runs if a supported LSP client is attached to the buffer.
local group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function(args)
    local bufnr = args.buf
    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/formatting") then
        local ft = vim.bo[bufnr].filetype
        if ft == "cpp" or ft == "c" then
          if client.name == "clangd" then
            vim.lsp.buf.format({ bufnr = bufnr, async = false, name = "clangd" })
          end
        elseif ft == "python" then
          if client.name == "pyright" then
            vim.lsp.buf.format({ bufnr = bufnr, async = false, name = "pyright" })
          end
        end
      end
    end
  end,
})

-- Prettier formatting for Vue files (only if Prettier is installed locally)
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*.vue",
  callback = function(args)
    if vim.fn.executable("node_modules/.bin/prettier") == 1 then
      vim.cmd("silent !node_modules/.bin/prettier " .. vim.fn.fnameescape(args.file) .. " -w")
    end
  end,
})

-- Ruff import sorting and formatting for Python (only if Ruff is installed)
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*.py",
  callback = function(args)
    if vim.fn.executable("ruff") == 1 then
      vim.cmd("silent !ruff check --select I --fix " .. vim.fn.fnameescape(args.file))
      vim.cmd("silent !ruff format " .. vim.fn.fnameescape(args.file))
    end
  end,
})
