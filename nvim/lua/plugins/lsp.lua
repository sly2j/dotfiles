-- Core LSP and completion capabilities setup
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- ^ Enables LSP servers to support advanced completion features provided by nvim-cmp

-- Diagnostic signs (Neovim 0.11+ compatible)
vim.diagnostic.config({
  virtual_text = true, -- Inline diagnostic messages
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
  underline = true,
  update_in_insert = false, -- Don't show diagnostics while typing
  severity_sort = true,     -- Sort diagnostics by severity in location list
})

-- Common callback when LSP attaches to a buffer
local on_attach = function(client, bufnr)
  -- Enable inlay hints (e.g., parameter names) if supported
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

-- Install and configure LSP servers via Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "pyright", "cmake" }, -- Automatically install these
})

-- Optionally ensure related CLI tools (formatters, linters) are installed
require("mason-tool-installer").setup {
  ensure_installed = {
    "clangd", "pyright", "cmake", -- LSPs
    "clang-format", "black", "mypy" -- Formatter/linter support
  }
}

-- clangd setup: C/C++ language server with background indexing and clang-tidy enabled
lspconfig.clangd.setup {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
  on_attach = on_attach,
  capabilities = capabilities,
}

-- pyright setup: Python LSP
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("pyproject.toml", ".git"),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,              -- Discover imports from workspace
        useLibraryCodeForTypes = true,       -- Show types for 3rd party libraries
        diagnosticMode = "openFilesOnly",    -- Avoid global project-wide analysis
        typeCheckingMode = "off",            -- Disable strict typing
        autoImportCompletions = false,       -- Reduce noisy suggestions
      }
    },
  },
})

-- cmake-language-server setup
lspconfig.cmake.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
}

-- Autocompletion setup (nvim-cmp + LuaSnip)
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load() -- Only loads snippets when needed

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- Required to expand LSP snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item
  }),
  sources = {
    { name = "nvim_lsp" }, -- LSP-based completion
    { name = "buffer" },   -- Words from current buffer
    { name = "path" },     -- File paths
    { name = "luasnip" },  -- LuaSnip snippets
    { name = "nvim_lua" }, -- Enable Neovim Lua API completion
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",  -- Show both symbol and text (e.g., ƒ function)
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

-- Cmdline `:` completion (commands and paths)
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

-- Cmdline `/` and `?` search completion (buffer content)
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Add rounded borders to hover and signature windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded" }
)
