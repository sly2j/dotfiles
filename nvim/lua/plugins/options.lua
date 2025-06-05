--vim.cmd("colorscheme catppuccin-macchiato")
vim.cmd("colorscheme catppuccin-mocha")

-- Bufferline setup
vim.opt.termguicolors = true  --bufferline
require('bufferline').setup {
  options = {
    -- You can choose "slant", "thick", "thin", or "padded_slant"
    separator_style = "slant",
    offsets = {
      {
        filetype = "NvimTree", -- or "neo-tree" or "oil" depending on your file tree
        text = "File Tree",    -- Optional label
        text_align = "center",
        separator = true       -- This draws a line between NvimTree and buffers
      }
    }
  }
}

-- Enable Tree-sitter based folding (folds by syntax structure, not indentation)
vim.opt.foldmethod = "expr"                        -- Use expression-based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"    -- Use Tree-sitter to compute folds
vim.opt.foldenable = false                         -- Start with all folds open (set to true to fold on open)
